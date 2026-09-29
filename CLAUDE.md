# ostest

**Stack:** Python 3 (stdlib only) | **License:** GPL-3.0

## What

A tiny Python project that reads its configuration from environment variables and prints a greeting.
It is a reference fixture used to validate open-source sanitization pipelines: the code contains no
hardcoded credentials, and every sensitive value is expected via the environment.

## Quick Start

```bash
./setup.sh                      # First-time setup (venv + .env)
source .venv/Scripts/activate   # Git Bash on Windows
# source .venv/bin/activate     # Linux / macOS
python src/app.py               # Loads config (see note below)
```

## Commands

```bash
# Environment
./setup.sh                      # Create .venv and copy .env.example -> .env

# Run
python src/app.py               # Reads the env vars, then exits (no __main__ guard)
python -c "import sys; sys.path.insert(0,'src'); import app; app.main()"   # prints "hello"

# Activate the virtual environment
source .venv/Scripts/activate   # Git Bash on Windows
source .venv/bin/activate       # Linux / macOS
```

There is no test suite, linter configuration, or build step in this project. Do not assume
`npm test`, `pytest`, or `make` exist — they do not.

## Architecture

```
ostest/
├── src/
│   └── app.py        # Entry point: reads env vars, defines main()
├── .env.example      # Template for required/optional configuration
└── setup.sh          # One-command bootstrap
```

`src/app.py` is a single module. At import time it reads five values from the environment
(`GITHUB_TOKEN`, `DATABASE_URL`, `PROJECT_EMAIL`, `PROJECT_HOME`, `API_KEY`) and binds them to
module-level names. `main()` prints a fixed greeting.

Note: the module currently has no `if __name__ == "__main__"` guard, so `python src/app.py` reads
the environment and exits. Call `main()` from another module or add a guard if you need the
greeting.

## Key Files

```
src/app.py          # The entire program: env-var reads + main()
.env.example        # Documented list of configuration variables
.gitignore          # Excludes .env, virtualenvs, __pycache__
CLAUDE.md           # This file
CONTRIBUTING.md     # How to contribute
LICENSE             # GPL-3.0
```

## Configuration

All configuration is via environment variables. See `.env.example`:

| Variable | Required | Description |
|----------|----------|-------------|
| `GITHUB_TOKEN` | Yes | GitHub personal access token, read via `os.environ["GITHUB_TOKEN"]` |
| `DATABASE_URL` | Yes | Database connection string, e.g. `postgres://USER:PASSWORD@HOST:PORT/DATABASE` |
| `API_KEY` | Yes | Application API key, read via `os.environ["API_KEY"]` |
| `PROJECT_EMAIL` | No | Contact / owner email; defaults to `you@your-domain.com` |
| `PROJECT_HOME` | No | Working directory; defaults to `./workspace` |

Required variables are read with `os.environ[...]`, so the program raises `KeyError` if they are
unset. Populate them by copying `.env.example` to `.env` and exporting it, or by exporting them
directly in your shell.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).
