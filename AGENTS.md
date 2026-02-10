# Repository Guidelines

## Project Structure & Module Organization
This repository is a small Ruby CLI for creating branch names from JIRA issues.
- `git-branch-creator`: executable entrypoint (interactive prefix selection + branch creation).
- `jira_api.rb`: JIRA API client (`/rest/api/2/issue/:id`) for issue title lookup.
- `config.rb`: loads `~/git_branch_creator.yml` and enforces secure file permissions.
- `utils.rb`: branch-name sanitization helpers.
- `spec/`: RSpec tests (`spec/git-switcher_spec.rb`) covering name sanitization behavior.
- `Makefile`: convenience targets for setup, symlink creation, and tests.
- `README.md`: usage and config examples.

## Build, Test, and Development Commands
- `make setup`: install Ruby dependencies (`bundle install` by default).
- `make test`: run the test suite (`bundle exec rspec spec/` by default).
- `make symlink`: create/update `~/.local/bin/git-branch-creator` symlink.
- `make setup BUNDLE="asdf exec bundle"`: run setup via `asdf` Ruby (optional override).
- `make test BUNDLE="asdf exec bundle"`: run tests via `asdf` Ruby (optional override).
- `bundle install`: direct dependency install command.
- `bundle exec rspec spec/`: direct test command.
- `./git-branch-creator "PRI-1234"`: run the CLI locally.
- `ruby -c git-branch-creator`: quick syntax check before committing.

Run commands from the repository root.

## Coding Style & Naming Conventions
- Use Ruby style with 2-space indentation and no tabs.
- Prefer `snake_case` for methods/variables (`read_user_input`, `sanitize_branch_name`).
- Use `require_relative` for local files.
- Keep classes focused: API logic in `JiraApi`, config logic in `Config`, string cleanup in `Utils`.
- Preserve the frozen string literal pragma when editing files that already use it.

## Testing Guidelines
- Framework: RSpec.
- Place specs under `spec/` and name files `*_spec.rb`.
- Prefer table-driven examples for sanitizer edge cases (symbols, slashes, mixed case, IDs).
- Run `make test` (or `bundle exec rspec spec/`) before opening a PR.

## Commit & Pull Request Guidelines
- Follow the existing commit style: concise, imperative, sentence-case summaries (e.g., `Add branch prefix selector, fix JIRA API URL, and improve security`).
- Keep commits scoped to one logical change.
- PRs should include:
  - what changed and why,
  - test evidence (`make test` output),
  - any config/security impact (especially `~/git_branch_creator.yml` permissions).

## Security & Configuration Tips
- Store credentials only in `~/git_branch_creator.yml`.
- Ensure strict permissions: `chmod 600 ~/git_branch_creator.yml`.
- Never commit API tokens, local config files, or issue data copied from private JIRA tickets.
