// POST /api/search { "query": string, "kinds"?: ["quran"|"hadith"], "limit"?: 1-10 }
//   -> { "matches": Match[], "notice": string }
//
// A thin proxy to peace-api, which searches all of the Quran and the stored
// hadith collections by meaning. It only returns stored texts with their
// references; it never writes an answer. peace-api applies the rate limits.
export const PEACE_API = "https://nbsbfhtsnitkchclxlwx.supabase.co/functions/v1/peace-api";
const MAX_QUERY = 500;
const KINDS = ["quran", "hadith"];

const json = (body, status = 200) =>
  Response.json(body, { status, headers: { "access-control-allow-origin": "*" } });

/** Checks a search request body; returns the body to forward or an error string. */
export function validate(body) {
  const { query, kinds, limit } = body ?? {};
  if (typeof query !== "string" || !query.trim() || query.length > MAX_QUERY) {
    return `query must be 1-${MAX_QUERY} characters`;
  }
  if (kinds !== undefined && !(Array.isArray(kinds) && kinds.length && kinds.every((k) => KINDS.includes(k)))) {
    return 'kinds must be a non-empty list of "quran" and "hadith"';
  }
  if (limit !== undefined && !(Number.isInteger(limit) && limit >= 1 && limit <= 10)) {
    return "limit must be an integer 1-10";
  }
  return { query: query.trim(), kinds, limit };
}

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
  let body;
  try {
    body = validate(await request.json());
  } catch {
    return json({ error: "invalid JSON" }, 400);
  }
  if (typeof body === "string") return json({ error: body }, 400);

  try {
    const res = await fetch(PEACE_API, {
      method: "POST",
      headers: { "content-type": "application/json" },
      body: JSON.stringify(body),
    });
    // Pass peace-api's status and body through (429 rate_limited / daily_limit included).
    return json(await res.json(), res.status);
  } catch (err) {
    console.error("[search]", err instanceof Error ? err.message : err);
    return json({ error: "search_unavailable" }, 503);
  }
}
