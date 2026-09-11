---
name: subagent-lifecycle
description: Use whenever launching, watching, or finishing a subagent. One agent per discrete task with a start and end condition, a 10 minute stall monitor while it runs, stopped when it reports, and a fresh agent for anything that follows.
---

# Subagent lifecycle

These rules override the defaults in any plugin skill about subagents. They exist because
agents have stalled on a background build, run unwatched for an hour, and kept counting time
after they were done.

## Launch

- One agent per discrete task. A task is one deliverable a reviewer could accept or reject on
  its own.
- The brief states a **start condition**: the exact state the agent begins from and how it
  verifies it (the branch to fast-forward onto, the commit hash it must see, the files to read
  first). If the check fails the agent stops and reports; it does nothing else.
- The brief states an **end condition**: the exact deliverable that means done (commits on its
  branch by layer, checks that must pass, files copied out, a report with named fields).
- The brief states a **budget** and a "stop and report if" clause for the blockers you can
  foresee (a command past 15 minutes, a dependency that will not build, a test that will not
  pass after two attempts).
- The brief says the lead runs the review, so the agent must not spawn reviewers of its own.
- The brief tells the agent that the one-line description on every tool call is what the user
  sees as its live status, so each must say the step and the file in plain words ("Write the
  failing press tests in tests/hold.rs", "Run the workspace tests after the release fix"), never
  a generic "debugging" or "running command". The Agent call's own description names the task.
- Builds run in the foreground with an explicit timeout. Never wait on a background build.
- In a worktree, never copy the main checkout's build directory and never share it with a
  second concurrent worktree: two worktrees building different versions of the same crate into
  one `target` produced a link against the other's half-edited code. Each worktree builds into
  its own directory under the main one, `CARGO_TARGET_DIR=<main>/target/worktrees/<name>`,
  which the lead deletes with the worktree. Keep dependency debug info trimmed so a fresh one is
  cheap (28 GB and a four minute cold build on bodtalk). Use the dev profile unless the task
  measures performance.

## While it runs

- Keep a 10 minute stall monitor armed whenever any agent is in flight. It reports each
  running worktree's HEAD, the size of the uncommitted diff in lines, the time of the newest
  source edit, and whether a cargo or rustc process is alive. A count of changed files alone
  reads steady work on the same files as a stall.
- Two consecutive reports with no change in any of those is a stall. Send one wrap-up
  message. Before stopping an agent after a further flat report, check the newest edit time
  directly; an edit in the last few minutes means it is working, not stalled. Only then stop
  it and launch a fresh one with a tighter brief.
- A running agent gets messages only to wrap up. Never assign it new work.

## When it reports

- Stop it with TaskStop so its timer ends. Its job is over.
- Integrate its branch, remove its worktree and branch, and dispatch the review as a new
  agent.
- Anything that follows, including fixes to that agent's own work, is a fresh agent with a
  fresh brief. Never resume a finished agent.
