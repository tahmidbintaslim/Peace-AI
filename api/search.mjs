// POST /api/search { "query": string } -> { "matches": [{ "reference", "score" }] }
//
// Search by meaning over the app's built-in verses and hadiths. It only
// ranks the existing texts; it never writes an answer, so the app keeps
// showing each text word for word with its reference and gives no rulings.
// Embeddings come from Vercel AI Gateway (text-embedding-3-small, which also
// reads Bangla), authenticated by the deployment's own OIDC token.
import { readFile } from "node:fs/promises";

const MODEL = "openai/text-embedding-3-small";
const GATEWAY = "https://ai-gateway.vercel.sh/v1/embeddings";
const MAX_QUERY = 500;
// shortcut: per-instance memory limit, not shared across instances; fine at
// a fraction of a cent per thousand queries, move to a shared store if abused.
const LIMIT_PER_MINUTE = 20;
const hits = new Map();

// knowledge.json is exported from lib/services/islamic_knowledge_service.dart
// (test/knowledge_export_test.dart fails when the two drift apart).
let corpus; // Promise<{ reference, vector }[]>, built once per instance

async function embed(input, token) {
  const res = await fetch(GATEWAY, {
    method: "POST",
    headers: { authorization: `Bearer ${token}`, "content-type": "application/json" },
    body: JSON.stringify({ model: MODEL, input }),
  });
  if (!res.ok) throw new Error(`gateway ${res.status}: ${(await res.text()).slice(0, 200)}`);
  return (await res.json()).data.map((d) => d.embedding);
}

async function loadCorpus(token) {
  const items = JSON.parse(await readFile(new URL("./knowledge.json", import.meta.url), "utf8"));
  const vectors = await embed(items.map((i) => i.text), token);
  return items.map((i, n) => ({ reference: i.reference, vector: vectors[n] }));
}

// Gateway vectors are unit length, so the dot product is the cosine.
const dot = (a, b) => a.reduce((s, x, i) => s + x * b[i], 0);

function allowed(ip, now = Date.now()) {
  const e = hits.get(ip);
  if (!e || now > e.resetAt) {
    if (hits.size > 5_000) hits.clear();
    hits.set(ip, { count: 1, resetAt: now + 60_000 });
    return true;
  }
  return ++e.count <= LIMIT_PER_MINUTE;
}

const json = (body, status = 200) =>
  Response.json(body, { status, headers: { "access-control-allow-origin": "*" } });

export function OPTIONS() {
  return new Response(null, {
    headers: {
      "access-control-allow-origin": "*",
      "access-control-allow-methods": "POST",
      "access-control-allow-headers": "content-type",
    },
  });
}

export async function POST(request) {
  const ip = (request.headers.get("x-forwarded-for") ?? "").split(",")[0].trim();
  if (!allowed(ip)) return json({ error: "rate_limited" }, 429);

  let query;
  try {
    query = (await request.json()).query;
  } catch {
    return json({ error: "invalid JSON" }, 400);
  }
  if (typeof query !== "string" || !query.trim() || query.length > MAX_QUERY) {
    return json({ error: `query must be 1-${MAX_QUERY} characters` }, 400);
  }

  const token = process.env.AI_GATEWAY_API_KEY || request.headers.get("x-vercel-oidc-token") || process.env.VERCEL_OIDC_TOKEN;
  if (!token) return json({ error: "search_unavailable" }, 503);

  try {
    corpus ??= loadCorpus(token).catch((err) => {
      corpus = undefined; // retry on the next request
      throw err;
    });
    const [items, [q]] = await Promise.all([corpus, embed([query.trim()], token)]);
    const matches = items
      .map((i) => ({ reference: i.reference, score: Math.round(dot(q, i.vector) * 1000) / 1000 }))
      .sort((a, b) => b.score - a.score)
      .slice(0, 5);
    return json({ matches });
  } catch (err) {
    console.error("[search]", err instanceof Error ? err.message : err);
    return json({ error: "search_unavailable" }, 503);
  }
}
