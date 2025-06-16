# ========== .zprofile ==========
# 1) Homebrew adds /opt/homebrew/bin and friends
eval "$(/opt/homebrew/bin/brew shellenv)"

# 2) Put GNU coreutils (gls, gcp, …) *before* the system tools
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

 
