# Global opencode instructions

## Workflow Process

- Before implementing, always sketch a plan and present it to the user for approval.
- Process: idea → plan → agree on plan → implement → code review → test → iterate → document.
- Before committing, use the task tool to launch a parallel code review agent to review all new/changed code.

## Git Usage

- You are unable to do interactive tasks such as `git rebase -i`
- When planning or implementing, always make commits at logical steps
- Make ALL commits as a single descriptive line followed by a list of changes in the commit.
  - DO NOT append anything else like clause authorship to the commit.
- DO NOT push work. Anything modifying the remote will be done manually by your partner.

## General Coding Guidelines

- Always review your work to ensure it is efficient and readable.
- Ensure your code is always covered by tests. Work should rarely be committed without tests passing that cover the work.
- Use as few comments as possible.
  - Docstrings are good, as are hints about tricky code.
  - Avoid comments that should be clear from the code.
