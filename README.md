# Tokyo Flutter Hackathon roulette App

## Setup

1. Install mise-en-place
  See: <https://mise.jdx.dev/>

1. Install dependencies

```bash
mise install
dart pub get --enforce-lockfile
```

1. Add pre-commit hook
  When you run git commit, this hook would be run automatically.
  In this hook, actionlint and pinact are run.

```bash
mise generate git-pre-commit -w
```
