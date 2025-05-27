#!/usr/bin/env bash

set -euo pipefail

##############################################################################
# 0) ensure we have basic download tools and adjust fetch function
##############################################################################
# prefer curl, fallback to wget
if command -v curl >/dev/null 2>&1; then
  fetch() { curl -L --fail --retry 3 --progress-bar -o "$2" -C - "$1"; }
elif command -v wget >/dev/null 2>&1; then
  fetch() { wget --progress=bar:force -O "$2" "$1"; }
else
  echo "Error: neither curl nor wget is installed. Please install one." >&2
  exit 1
fi

# add local bin to PATH immediately
export PATH="$HOME/.local/bin:$PATH"

##############################################################################
# Helper ─────────────────────────────────────────────────────────────────────
##############################################################################
INSTALL_ROOT="$HOME/.local"
BIN_DIR="$INSTALL_ROOT/bin"
CACHE="$HOME/.cache/dot_boot"
mkdir -p "$BIN_DIR" "$CACHE"

need()   { command -v "$1" >/dev/null 2>&1 || MISSING+=("$1"); }
untar()  { tar -xf "$1" -C "$2" --strip-components="${3:-1}"; }

##############################################################################
# 1) detect what is already on the host
##############################################################################
MISSING=()
need nvim
need rg
need stow

##############################################################################
# 2) install tools the user is missing
##############################################################################
if [[ ! " ${MISSING[*]} " =~ " stow " ]]; then 
    : # stow present
else 
    if [[ "$(uname)" == "Darwin" ]] && command -v brew >/dev/null 2>&1; then
        echo "Installing GNU Stow via Homebrew"
        brew install stow
        # re-check 
        MISSING=(); need stow
    else 
        echo "Warning: GNU Stow is not installed and cannot be auto-installed."
        echo "Please install 'stow' and re-run this script."
        exit 1
    fi
fi

##############################################################################
# 3) Install tools the user is missing
##############################################################################
# architecture mapping
ARCH="$(uname -m)"
case "$ARCH" in 
    x86_64) NODE_ARCH="x64";;
    arm64) NODE_ARCH="arm64";;
    aarch64) NODE_ARCH="arm65";;
esac

for tool in "${MISSING[@]}" ; do
    case "$tool" in 
        nvim) 
            echo "Installing Neovim..."
            if [[ "$(uname)" == "Darwin" ]]; then
                # macOS tarball via Homebrew
                if command -v brew >/dev/null 2>&1; then
                    brew install neovim
                else
                    echo "Error: Homebrew not found on macOS. Cannot install Neovim" >&2
                    exit 1
                fi
            else 
                # Linux: try AppImage, fallback to portable tar.gz
                NVIM_APP="$CACHE/nvim.appimage" 
                NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.appimage"
                echo "Fetching Neovim AppImage"
                if fetch "$NVIM_URL" "$NVIM_APP"; then
                    chmod +x "$NVIM_APP" 
                    "$NVIM_APP" --appimage-xtract >/dev/null
                    mv "$CACHE/squashfs-root/user/bin/nvim" "$BIN_DIR/"
                else 
                    echo "AppImage failed; falling back to tarball"
                    TAR_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz"
                    TAR_FILE="$CACHE/nvim.tar.gz"
                    fetch "$TAR_URL" "$TAR_FILE"
                    untar "$TAR_URL" "$TAR_FILE" 1
                    mv "$CACHE/nvim/bin/nvim" "$BIN_DIR/"
                fi
                # checksum verification
                if command -v sha256sum >/dev/null 2>&1; then
                    for file in "$NVIM_APP" "$TAR_FILE"; do 
                        sha_file="${file}.sha256"
                        if fetch "${file}.sha256" "$sha_file" 2>/dev/null; then
                            sha256sum -c "$sha_file" --status || echo | "Warning: checksum mismatch for $file"
                        fi
                    done
                fi
            fi
            ;;
        rg)
            echo "▶ installing ripgrep"
            if [[ "$(uname)" == "Darwin" ]]; then
                brew install ripgrep
            # consider changing this later to something not so greppy
            else
                RG_URL="$(curl -s https://api.github.com/repos/BurntSushi/ripgrep/releases/latest \
                      | grep browser_download_url \
                      | grep 'linux.*x86_64.*.tar.gz' -m1 \
                      | cut -d '"' -f4)"
                TGZ="$CACHE/rg.tgz"
                fetch "$RG_URL" "$TGZ"
                untar "$TGZ" "$CACHE/rgdir"
                mv "$CACHE/rgdir/rg" "$BIN_DIR/"
                # checksum
                if command -v sha256sum >/dev/null 2>&1; then
                    if fetch "${RG_URL}.sha256" "$TGZ.sha256" 2>/dev/null; then
                        sha256sum -c "$TGZ.sha256" --status || echo "Warning: checksum mismatch for ripgrep"
                    fi
                fi
            fi
            ;;
    esac
    # mark tool as installed
    unset MISSING; MISSING=(); need "$tool"
done

##############################################################################
# 4) dotfile symlinks with GNU Stow (already in repo)
##############################################################################
cd "$(dirname "$0")"
stow --restow zsh nvim git

echo "✔  Done – executables placed in $BIN_DIR"

