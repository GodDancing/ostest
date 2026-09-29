# ostest

A tiny Python test project — a reference fixture for validating open-source sanitization pipelines.

It contains a single module that reads all of its configuration from environment variables and
prints a greeting. There are no hardcoded credentials or absolute paths anywhere in the source.

## Features

- Single-module Python program with no third-party dependencies
- All configuration driven by environment variables (see `.env.example`)
- One-command bootstrap via `setup.sh` for Windows, Linux, and macOS
- Ships with `CLAUDE.md` so Claude Code has full project context out of the box

## Quick Start

```bash
git clone https://github.com/GodDancing/ostest.git
cd ostest
./setup.sh
```

Then edit `.env`, activate the virtual environment, and run:

```bash
source .venv/Scripts/activate   # Git Bash on Windows
# source .venv/bin/activate     # Linux / macOS
python src/app.py
```

See [CLAUDE.md](CLAUDE.md) for detailed commands and architecture.

## Prerequisites

- Python 3.8 or newer (3.11 recommended)
- Git Bash (required on Windows; Linux and macOS use the system shell)

## Installation

The project has no third-party dependencies, so setup is just:

```bash
./setup.sh
```

This verifies your Python version, creates a `.venv` virtual environment, and copies
`.env.example` to `.env`.

## Configuration

```bash
cp .env.example .env
```

Key settings:

| Variable | Required | Description |
|----------|----------|-------------|
| `GITHUB_TOKEN` | Yes | GitHub personal access token |
| `DATABASE_URL` | Yes | Database connection string |
| `API_KEY` | Yes | Application API key |
| `PROJECT_EMAIL` | No | Contact email (defaults to `you@your-domain.com`) |
| `PROJECT_HOME` | No | Working directory (defaults to `./workspace`) |

`src/app.py` reads these directly from the environment. Export them in your shell (or load `.env`
with your tool of choice) before running the program.

## Running

```bash
# Reads the environment variables, then exits (src/app.py has no __main__ guard yet)
python src/app.py

# To see the greeting, call main() explicitly
python -c "import sys; sys.path.insert(0, 'src'); import app; app.main()"
```

## Development

```bash
./setup.sh            # Create .venv and .env
python src/app.py     # Run the program
```

There is no test suite, linter config, or build step in this project.

## Using with Claude Code

This project includes a `CLAUDE.md` that gives Claude Code full context.

```bash
claude    # Start Claude Code — it reads CLAUDE.md automatically
```

## License

GPL-3.0 — see [LICENSE](LICENSE)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)
