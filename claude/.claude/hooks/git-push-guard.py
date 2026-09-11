#!/usr/bin/env python3
"""PreToolUse hook: prompt before any Bash command whose git subcommand is `push`.

Permission globs cannot express "exactly one token", so `Bash(git -C * push*)`
also matches `git -C <path> stash push`. This hook parses git's argv instead and
answers `ask` only when the subcommand itself is `push`.

Known limitation: an alias defined inline (`git -c alias.p=push p`) is not
resolved. Nothing in this setup emits that form.
"""

import json
import os
import re
import shlex
import sys

SEGMENT_SEPARATORS = {"|", "||", "&&", ";", "&", "(", ")", "\n"}
WRAPPER_PROGRAMS = {"env", "command", "sudo", "nohup", "time"}
SHELL_PROGRAMS = {"sh", "bash", "zsh", "dash"}
GIT_GLOBAL_OPTIONS_WITH_ARG = {
    "-C",
    "-c",
    "--git-dir",
    "--work-tree",
    "--namespace",
    "--super-prefix",
    "--config-env",
}
ENV_ASSIGNMENT = re.compile(r"^[A-Za-z_][A-Za-z0-9_]*=")


def tokenize(command):
    lexer = shlex.shlex(command, posix=True, punctuation_chars="();|&\n")
    lexer.whitespace = " \t\r"
    lexer.whitespace_split = True
    return list(lexer)


def split_into_segments(tokens):
    segments, current = [], []
    for token in tokens:
        if token in SEGMENT_SEPARATORS:
            if current:
                segments.append(current)
            current = []
        else:
            current.append(token)
    if current:
        segments.append(current)
    return segments


def strip_wrappers(segment):
    index = 0
    while index < len(segment):
        token = segment[index]
        if ENV_ASSIGNMENT.match(token) or os.path.basename(token) in WRAPPER_PROGRAMS:
            index += 1
        else:
            break
    return segment[index:]


def git_subcommand(argv):
    if not argv or os.path.basename(argv[0]) != "git":
        return None
    index = 1
    while index < len(argv):
        token = argv[index]
        if not token.startswith("-"):
            return token
        if token in GIT_GLOBAL_OPTIONS_WITH_ARG:
            index += 2
        else:
            index += 1
    return None


def inline_shell_script(argv):
    if not argv or os.path.basename(argv[0]) not in SHELL_PROGRAMS:
        return None
    for index, token in enumerate(argv[1:-1], start=1):
        if token == "-c":
            return argv[index + 1]
    return None


def segment_pushes(segment):
    argv = strip_wrappers(segment)
    if not argv:
        return False
    if os.path.basename(argv[0]) == "git-push":
        return True
    if git_subcommand(argv) == "push":
        return True
    script = inline_shell_script(argv)
    return script is not None and command_pushes(script)


def command_pushes(command):
    try:
        tokens = tokenize(command)
    except ValueError:
        return re.search(r"\bpush\b", command) is not None
    return any(segment_pushes(segment) for segment in split_into_segments(tokens))


def main():
    payload = json.load(sys.stdin)
    command = payload.get("tool_input", {}).get("command", "")
    if not command_pushes(command):
        return
    json.dump(
        {
            "hookSpecificOutput": {
                "hookEventName": "PreToolUse",
                "permissionDecision": "ask",
                "permissionDecisionReason": "git push requires confirmation (git-push-guard hook)",
            }
        },
        sys.stdout,
    )


if __name__ == "__main__":
    main()
