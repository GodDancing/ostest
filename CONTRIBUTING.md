# Contributing to ostest

Thanks for your interest in improving ostest. This document explains how to set up a development
environment and how to propose changes.

## Development Setup

1. Fork and clone the repository:

   ```bash
   git clone https://github.com/<your-username>/ostest.git
   cd ostest
   ```

2. Run the bootstrap script, which verifies your Python version, creates a `.venv`, and copies
   `.env.example` to `.env`:

   ```bash
   ./setup.sh
   ```

3. Activate the virtual environment:

   ```bash
   source .venv/Scripts/activate   # Git Bash on Windows
   source .venv/bin/activate       # Linux / macOS
   ```

4. Fill in the required variables in `.env` (`GITHUB_TOKEN`, `DATABASE_URL`, `API_KEY`) and run:

   ```bash
   python src/app.py
   ```

See [CLAUDE.md](CLAUDE.md) for the full command reference and architecture notes.

## Branch and Pull Request Workflow

1. Create a topic branch off `main`:

   ```bash
   git checkout -b feat/short-description
   ```

2. Make your change, keeping commits focused and the history clean.
3. Run the program locally to confirm nothing is broken:

   ```bash
   python src/app.py
   ```

4. Push your branch and open a pull request against `main`. Describe the motivation for the
   change and how you tested it.

## Code Style

- Python, standard library only — please do not introduce third-party runtime dependencies
  without discussing it in an issue first.
- Match the existing style in `src/app.py`: concise, lowercase module-level names, short English
  comments explaining *why* rather than *what*.
- Keep comments in English.

## Never Commit Secrets

This project is a sanitization reference fixture. It must never contain real credentials, tokens,
private IPs, or machine-specific absolute paths.

- Commit only `.env.example`, with placeholder values.
- Never commit `.env` — it is already listed in `.gitignore`.
- If you find a secret in the repository or its history, report it privately to the maintainers
  rather than opening a public issue.

## Reporting Issues

- Use the issue templates under `.github/ISSUE_TEMPLATE/` for bug reports and feature requests.
- Search existing issues before filing a new one.
- For security-sensitive reports, contact the maintainers privately first.

## Using Claude Code

If you use Claude Code, this repository ships with a `CLAUDE.md`:

```bash
claude    # Start Claude Code — it reads CLAUDE.md automatically
```
