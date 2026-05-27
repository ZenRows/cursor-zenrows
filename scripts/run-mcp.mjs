#!/usr/bin/env node
// Manual test launcher for @zenrows/mcp.
// Reads ~/.zenrows.env as a fallback if ZENROWS_API_KEY is not already set in the environment.
// The installed plugin uses npx directly via .mcp.json — this script is for local debugging only.
import { readFileSync } from "node:fs";
import { homedir } from "node:os";
import { spawn } from "node:child_process";

try {
  for (const line of readFileSync(`${homedir()}/.zenrows.env`, "utf8").split("\n")) {
    const trimmed = line.trim();
    if (!trimmed || trimmed.startsWith("#")) continue;
    const i = trimmed.indexOf("=");
    if (i > 0) process.env[trimmed.slice(0, i).trim()] = trimmed.slice(i + 1).trim();
  }
} catch {
  // fall through to env-var check
}

if (!process.env.ZENROWS_API_KEY) {
  console.error("ZENROWS_API_KEY is not set. Create ~/.zenrows.env or export ZENROWS_API_KEY.");
  process.exit(1);
}

const child = spawn("npx", ["-y", "@zenrows/mcp"], { stdio: "inherit", env: process.env });
child.on("exit", (code, signal) => {
  if (signal) process.kill(process.pid, signal);
  process.exit(code ?? 1);
});
