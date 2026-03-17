# Install Instruction Snippets

This repo is a snippet store. Use the installer script to copy instruction files into:
1. a target repository, or
2. a user-level config location.

Primary scripts:
- `scripts/install-instruction-snippets.sh`
- `scripts/install-instruction-snippets.ps1`

## 1) Install into a target repository

Copies snippets to standard repo-level locations:
- `AGENTS.md`
- `CLAUDE.md`
- `GEMINI.md`
- `.github/copilot-instructions.md`

Example:

```bash
./scripts/install-instruction-snippets.sh repo --target-repo /path/to/target-repo
```

```powershell
./scripts/install-instruction-snippets.ps1 repo -TargetRepo C:\path\to\target-repo
```

Only selected files:

```bash
./scripts/install-instruction-snippets.sh repo --target-repo /path/to/target-repo --templates "AGENTS CLAUDE"
```

```powershell
./scripts/install-instruction-snippets.ps1 repo -TargetRepo C:\path\to\target-repo -Templates AGENTS,CLAUDE
```

## 2) Install into user config

Use either a profile shortcut or an explicit target file.

### Profile shortcuts

Claude profile:

```bash
./scripts/install-instruction-snippets.sh user --profile claude
```

```powershell
./scripts/install-instruction-snippets.ps1 user -Profile claude
```

Gemini profile:

```bash
./scripts/install-instruction-snippets.sh user --profile gemini
```

```powershell
./scripts/install-instruction-snippets.ps1 user -Profile gemini
```

### Explicit target file

```bash
./scripts/install-instruction-snippets.sh user --template AGENTS --target-file /absolute/path/to/AGENTS.md
```

```powershell
./scripts/install-instruction-snippets.ps1 user -Template AGENTS -TargetFile C:\absolute\path\to\AGENTS.md
```

## Overwrite behavior

By default, installer will not overwrite existing files.

Use `--force` to overwrite:

```bash
./scripts/install-instruction-snippets.sh repo --target-repo /path/to/target-repo --force
```

```powershell
./scripts/install-instruction-snippets.ps1 repo -TargetRepo C:\path\to\target-repo -Force
```

