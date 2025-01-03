if test (command -v nvim)
    set -e EDITOR
    set -Ux EDITOR (command -v nvim)
end

set -e VISUAL
set -Ux VISUAL $EDITOR
set -e BAT_THEME
set -Ux BAT_THEME gruvbox-dark

source $(status dirname)/alias.fish

if status is-interactive
    # Key bindings: vim and default emacs
    fish_hybrid_key_bindings

    if test -e ~/.fishrc
        source ~/.fishrc
    end
end

if test (command -v direnv)
    direnv hook fish | source
end

if test (command -v zoxide)
    zoxide init fish | source
end

if test (command -v fzf)
    fzf --fish | source
end
