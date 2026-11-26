#!/usr/bin/bash
# Truncate Neovim's LSP log if it's larger than 10 MiB.
 
log="${XDG_STATE_HOME:-$HOME/.local/state}/nvim/lsp.log"
max=$((10 * 1024 * 1024))
 
if [ -f "$log" ] && [ "$(stat -c %s "$log")" -gt "$max" ]; then
    : > "$log"
fi
