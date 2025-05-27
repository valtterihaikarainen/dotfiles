# Dotfiles Repository

A personal-use version-controlled collection of my shell, editor, and Git configurations, organized for easy deployment across machines.

> **Note:** The `bootstrap.sh` script is not included in this public repository for now.
---
## Table of Contents
1. [Overview](#overview)
2. [Prerequisites](#prerequisites)
3. [Repository Structure](#repository-structure)
4. [Installation](#installation)
5. [Usage](#usage)
6. [Updating](#updating)
7. [Contributing](#contributing)
8. [License](#license)

---

## Overview

This repository contains:

- **Zsh configuration** (`.zshrc`, `.zprofile`)
- **Git configuration** (`.gitconfig`)
- **Neovim configuration** (`.config/nvim/...`)

All files are organized into separate `git/`, `zsh/`, and `nvim/` packages and managed via GNU Stow for idempotent symlink deployment.

---

## Prerequisites

On any new machine, you need at least one of:

- `git` (to clone this repo)
- `curl` or `wget` (for downloading tools in the bootstrap)

### (Private) Bootstrap Script

A helper script (`bootstrap.sh`) installs:
- GNU Stow (if missing, into `$HOME/.local/bin`)
- Neovim, ripgrep, Node.js (into `$HOME/.local/bin` without requiring `sudo`)
- Sets up the Stow symlinks

Obtain `bootstrap.sh` privately and place it at the root of this repo clone before running.

---

## Repository Structure

```text
dotfiles/
├── git/
│   └── .gitconfig
├── zsh/
│   ├── .zshrc
│   └── .zprofile
└── nvim/
    └── .config/nvim/
        ├── init.lua
        └── lua/…
```

Each top-level folder corresponds to a Stow package. Files within mirror the paths they will occupy under `$HOME`.

---

## Installation

1. **Clone** the repo:
   ```bash
   git clone https://github.com/valtterihaikarainen/dotfiles.git ~/dotfiles
   ```
2. **Copy** the private `bootstrap.sh` into `~/dotfiles/` (not tracked here).
3. **Run** the bootstrap script:
   ```bash
   cd ~/dotfiles
   bash bootstrap.sh
   ```
