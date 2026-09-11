import importlib.util
import io
import json
import unittest
from pathlib import Path

SCRIPT = Path(__file__).with_name("git-push-guard.py")
spec = importlib.util.spec_from_file_location("git_push_guard", SCRIPT)
guard = importlib.util.module_from_spec(spec)
spec.loader.exec_module(guard)


class CommandPushes(unittest.TestCase):
    def assert_pushes(self, command):
        self.assertTrue(guard.command_pushes(command), command)

    def assert_allows(self, command):
        self.assertFalse(guard.command_pushes(command), command)

    def test_plain_push(self):
        self.assert_pushes("git push")
        self.assert_pushes("git push origin main")
        self.assert_pushes("git push --force-with-lease")

    def test_push_with_global_options(self):
        self.assert_pushes("git -C /home/mason/Code/soshi push")
        self.assert_pushes("git -C /repo -c push.default=simple push origin main")
        self.assert_pushes("git --git-dir=/repo/.git --no-pager push")
        self.assert_pushes("git --git-dir /repo/.git push")

    def test_push_inside_compound(self):
        self.assert_pushes("git status && git push")
        self.assert_pushes("git fetch; git -C /repo push")
        self.assert_pushes("git log -n 1 | cat && git push")
        self.assert_pushes("git status\ngit push")

    def test_absolute_and_dash_binary(self):
        self.assert_pushes("/usr/bin/git push")
        self.assert_pushes("git-push origin main")

    def test_stash_push_is_allowed(self):
        self.assert_allows("git stash push")
        self.assert_allows("git -C /home/mason/Code/soshi stash push")
        self.assert_allows("git -C /repo stash push -m 'wip push work'")

    def test_push_as_argument_is_allowed(self):
        self.assert_allows("git -C /repo log --grep push")
        self.assert_allows("git -C /repo checkout push-fix")
        self.assert_allows("git commit -m 'do not push yet'")
        self.assert_allows("git -C /repo add pushed.txt")

    def test_non_git_is_allowed(self):
        self.assert_allows("echo git push")
        self.assert_allows("ls -la")
        self.assert_allows("")

    def test_unparseable_falls_back_to_word_search(self):
        self.assert_pushes("git push 'unterminated")
        self.assert_allows("git commit -m 'unterminated")

    def test_heredoc_commit_then_push(self):
        heredoc = "git commit -m \"$(cat <<'EOF'\nsome notes\nEOF\n)\""
        self.assert_pushes(heredoc + " && git push")
        self.assert_allows(heredoc)
        self.assert_allows(heredoc.replace("some notes", "do not push"))

    def test_multiline_push_after_quoted_newline(self):
        self.assert_pushes("git commit -m 'line one\nline two'\ngit push")
        self.assert_allows("git commit -m 'line one\nline two'\ngit status")

    def test_env_and_wrapper_prefixes(self):
        self.assert_pushes("GIT_SSH_COMMAND='ssh -i key' git push origin main")
        self.assert_pushes("env GIT_TRACE=1 git -C /repo push")
        self.assert_pushes("command git push")
        self.assert_allows("GIT_SSH_COMMAND='ssh -i key' git -C /repo stash push")

    def test_inline_shell_script(self):
        self.assert_pushes("sh -c 'git push origin main'")
        self.assert_pushes("bash -c 'git fetch && git -C /repo push'")
        self.assert_allows("bash -c 'git -C /repo stash push'")
        self.assert_allows("bash -c 'echo push'")

    def test_stdin_contract(self):
        payload = json.dumps({"tool_input": {"command": "git -C /repo push"}})
        out = io.StringIO()
        original_stdin, original_stdout = guard.sys.stdin, guard.sys.stdout
        try:
            guard.sys.stdin, guard.sys.stdout = io.StringIO(payload), out
            guard.main()
        finally:
            guard.sys.stdin, guard.sys.stdout = original_stdin, original_stdout
        decision = json.loads(out.getvalue())["hookSpecificOutput"]
        self.assertEqual(decision["permissionDecision"], "ask")
        self.assertEqual(decision["hookEventName"], "PreToolUse")


if __name__ == "__main__":
    unittest.main()
