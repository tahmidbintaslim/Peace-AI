// Self-check for api/search.mjs and api/mcp.mjs with a mocked fetch.
// Run: node test/api_check.mjs
import assert from "node:assert/strict";
import * as search from "../api/search.mjs";
import * as mcp from "../api/mcp.mjs";

const hadith = {
  id: "h:1", kind: "hadith", score: 0.6, reference: "Sahih al-Bukhari, book 1, hadith 1", url: null,
  arabic: "إِنَّمَا الأَعْمَالُ بِالنِّيَّاتِ", english: "Actions are by intentions.", bengali: "কাজ নিয়ত অনুযায়ী।", grade: null,
};
const notice = "These are stored texts found by meaning, not a ruling.";
let sent;
let reply = { status: 200, body: { matches: [hadith], notice } };
globalThis.fetch = async (url, init) => {
  sent = { url, body: JSON.parse(init.body) };
  return Response.json(reply.body, { status: reply.status });
};

const post = (mod, body) =>
  mod.POST(new Request("http://x/api", { method: "POST", body: typeof body === "string" ? body : JSON.stringify(body) }));
const rpc = async (body) => {
  const res = await post(mcp, body);
  return { status: res.status, json: res.status === 202 ? null : await res.json() };
};

// search proxy
assert.equal((await post(search, "{")).status, 400);
assert.equal((await post(search, { query: "" })).status, 400);
assert.equal((await post(search, { query: "x".repeat(501) })).status, 400);
assert.equal((await post(search, { query: "a", kinds: ["fiqh"] })).status, 400);
assert.equal((await post(search, { query: "a", limit: 11 })).status, 400);
let res = await post(search, { query: " patience ", kinds: ["hadith"], limit: 2 });
assert.equal(res.status, 200);
assert.deepEqual(sent.body, { query: "patience", kinds: ["hadith"], limit: 2 });
assert.equal((await res.json()).matches[0].reference, hadith.reference);
reply = { status: 429, body: { error: "daily_limit" } };
res = await post(search, { query: "a" });
assert.equal(res.status, 429);
assert.equal((await res.json()).error, "daily_limit");

// MCP
reply = { status: 200, body: { matches: [hadith], notice } };
let r = await rpc({ jsonrpc: "2.0", id: 1, method: "initialize", params: { protocolVersion: "2025-03-26" } });
assert.equal(r.json.result.protocolVersion, "2025-03-26");
assert.deepEqual(r.json.result.capabilities, { tools: {} });
assert.equal(r.json.result.serverInfo.name, "peace-ai");
r = await rpc({ jsonrpc: "2.0", id: 1, method: "initialize", params: {} });
assert.equal(r.json.result.protocolVersion, "2025-06-18");
assert.equal((await rpc({ jsonrpc: "2.0", method: "notifications/initialized" })).status, 202);
assert.deepEqual((await rpc({ jsonrpc: "2.0", id: 2, method: "ping" })).json.result, {});
r = await rpc({ jsonrpc: "2.0", id: 3, method: "tools/list" });
assert.deepEqual(r.json.result.tools.map((t) => t.name), ["search_quran", "search_hadith"]);

r = await rpc({ jsonrpc: "2.0", id: 4, method: "tools/call", params: { name: "search_hadith", arguments: { query: "intention", limit: 3 } } });
assert.deepEqual(sent.body, { query: "intention", kinds: ["hadith"], limit: 3 });
const text = r.json.result.content[0].text;
for (const part of [hadith.reference, hadith.arabic, hadith.bengali, hadith.english, "Grade: not stated in the source", notice]) {
  assert.ok(text.includes(part), `missing ${part}`);
}
assert.equal(r.json.result.isError, undefined);

await rpc({ jsonrpc: "2.0", id: 5, method: "tools/call", params: { name: "search_quran", arguments: { query: "mercy" } } });
assert.deepEqual(sent.body, { query: "mercy", kinds: ["quran"], limit: 5 });

reply = { status: 503, body: { error: "unavailable" } };
r = await rpc({ jsonrpc: "2.0", id: 6, method: "tools/call", params: { name: "search_quran", arguments: { query: "mercy" } } });
assert.equal(r.json.result.isError, true);
r = await rpc({ jsonrpc: "2.0", id: 7, method: "tools/call", params: { name: "search_quran", arguments: { query: "" } } });
assert.equal(r.json.result.isError, true);
r = await rpc({ jsonrpc: "2.0", id: 8, method: "tools/call", params: { name: "nope", arguments: {} } });
assert.equal(r.json.error.code, -32602);
assert.equal((await rpc({ jsonrpc: "2.0", id: 9, method: "resources/list" })).json.error.code, -32601);
assert.equal((await post(mcp, "{")).status, 400);
assert.equal(mcp.GET().status, 405);

console.log("api self-check passed");
