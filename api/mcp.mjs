// POST /api/mcp: a stateless MCP server (Streamable HTTP, JSON responses).
// Tools search_quran and search_hadith return stored texts from peace-api
// with their references; they never write an answer or a ruling.
import { PEACE_API } from "./search.mjs";

const VERSION = "1.0.0";
const PROTOCOL = "2025-06-18";

const inputSchema = {
  type: "object",
  properties: {
    query: { type: "string", minLength: 1, maxLength: 500, description: "A question or topic, in Bangla or English" },
    limit: { type: "integer", minimum: 1, maximum: 10, description: "How many texts to return (default 5)" },
  },
  required: ["query"],
};

const TOOLS = [
  {
    name: "search_quran",
    description:
      "Search all 6236 ayat of the Quran by meaning (Bangla or English questions). Returns the stored Arabic text with Bangla and English translations and the reference. Search results, not rulings.",
    inputSchema,
  },
  {
    name: "search_hadith",
    description:
      "Search about 3700 hadith from ten collections by meaning (Bangla or English questions). Returns the stored Arabic, Bangla and English text, the reference, and the grade only when the source gives one. Search results, not rulings.",
    inputSchema,
  },
];

const KIND = { search_quran: "quran", search_hadith: "hadith" };

/** One match as plain text: reference, Arabic, Bangla, English, grade. */
export function formatMatch(m) {
  const lines = [m.reference + (m.url ? ` (${m.url})` : "")];
  if (m.arabic) lines.push(`Arabic: ${m.arabic}`);
  if (m.bengali) lines.push(`Bangla: ${m.bengali}`);
  if (m.english) lines.push(`English: ${m.english}`);
  if (m.kind === "hadith") lines.push(`Grade: ${m.grade ?? "not stated in the source"}`);
  return lines.join("\n");
}

async function callTool(name, args = {}) {
  const kind = KIND[name];
  if (!kind) return null;
  const { query, limit } = args;
  const fail = (text) => ({ content: [{ type: "text", text }], isError: true });
  if (typeof query !== "string" || !query.trim() || query.length > 500) return fail("query must be 1-500 characters");
  if (limit !== undefined && !(Number.isInteger(limit) && limit >= 1 && limit <= 10)) return fail("limit must be an integer 1-10");
  try {
    const res = await fetch(PEACE_API, {
      method: "POST",
      headers: { "content-type": "application/json" },
      body: JSON.stringify({ query: query.trim(), kinds: [kind], limit: limit ?? 5 }),
    });
    const body = await res.json().catch(() => ({}));
    if (!res.ok) return fail(`Search failed (${res.status}${body.error ? `: ${body.error}` : ""}). Try again later.`);
    const parts = body.matches.length ? body.matches.map(formatMatch) : ["No matching texts found."];
    return { content: [{ type: "text", text: [...parts, body.notice].join("\n\n") }] };
  } catch (err) {
    return fail(`Search unavailable: ${err instanceof Error ? err.message : err}`);
  }
}

/** Handles one JSON-RPC message; returns the response object, or null for a notification. */
export async function handle(msg) {
  const { id, method, params } = msg ?? {};
  const isNotification = id === undefined || id === null;
  const ok = (result) => ({ jsonrpc: "2.0", id, result });
  const err = (code, message) => ({ jsonrpc: "2.0", id: id ?? null, error: { code, message } });

  if (msg?.jsonrpc !== "2.0" || typeof method !== "string") return err(-32600, "Invalid Request");
  if (isNotification) return null; // notifications/initialized and friends need no answer

  switch (method) {
    case "initialize":
      return ok({
        protocolVersion: typeof params?.protocolVersion === "string" ? params.protocolVersion : PROTOCOL,
        capabilities: { tools: {} },
        serverInfo: { name: "peace-ai", version: VERSION },
        instructions:
          "Every result is stored Quran or hadith text with its reference. Quote it as given; do not present it as a ruling.",
      });
    case "ping":
      return ok({});
    case "tools/list":
      return ok({ tools: TOOLS });
    case "tools/call": {
      const result = await callTool(params?.name, params?.arguments);
      return result ? ok(result) : err(-32602, `Unknown tool: ${params?.name}`);
    }
    default:
      return err(-32601, `Method not found: ${method}`);
  }
}

const CORS = {
  "access-control-allow-origin": "*",
  "access-control-allow-headers": "content-type, mcp-protocol-version, mcp-session-id",
  "access-control-allow-methods": "POST, GET, OPTIONS",
};

export async function POST(request) {
  let msg;
  try {
    msg = await request.json();
  } catch {
    return Response.json({ jsonrpc: "2.0", id: null, error: { code: -32700, message: "Parse error" } }, { status: 400, headers: CORS });
  }
  // shortcut: batches (dropped from the 2025-06-18 spec) are not supported.
  if (Array.isArray(msg)) {
    return Response.json({ jsonrpc: "2.0", id: null, error: { code: -32600, message: "Batches are not supported" } }, { status: 400, headers: CORS });
  }
  const reply = await handle(msg);
  if (!reply) return new Response(null, { status: 202, headers: CORS });
  return Response.json(reply, { headers: CORS });
}

// No server-to-client stream: this server is stateless.
export function GET() {
  return new Response("Method Not Allowed", { status: 405, headers: { ...CORS, allow: "POST" } });
}

export function OPTIONS() {
  return new Response(null, { status: 204, headers: CORS });
}
