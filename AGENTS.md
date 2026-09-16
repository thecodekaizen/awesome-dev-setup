# Engineering Rules

## General

- Inspect existing code before making changes.
- Prefer small, focused changes.
- Preserve existing architecture unless there is a concrete reason to change it.
- Do not add dependencies without explaining why they are needed.
- Do not modify unrelated files.
- Prefer simple, maintainable solutions over clever abstractions.

## Safety

- Never expose, print, commit, or modify secrets.
- Never read private SSH keys.
- Never access files outside the project unless explicitly requested.
- Never use production credentials or production infrastructure unless explicitly requested.
- Do not run destructive commands without explicit confirmation.
- Do not delete databases, data, branches, or files unless explicitly requested.
- Do not use force-push or history-rewriting commands unless explicitly requested.

## Git

- Never rewrite Git history unless explicitly requested.
- Never force-push unless explicitly requested.
- Do not create commits unless explicitly asked.
- Inspect the diff before declaring work complete.
- Keep commits focused and descriptive.

## Quality

- Run relevant tests after making changes.
- Run formatting and linting when available.
- Check error paths, edge cases, and backwards compatibility.
- Explain test or tooling failures instead of hiding them.

## Dependencies

- Prefer the existing stack and standard library where practical.
- Before adding a dependency, check whether the functionality already exists in the project.
- Avoid unnecessary framework or infrastructure changes.

## Completion

Before finishing a task:

1. Review the changed files.
2. Review the diff.
3. Run relevant tests.
4. Run formatting/linting where applicable.
5. Report what changed.
6. Report anything that could not be verified.
