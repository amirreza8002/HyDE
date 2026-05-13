#  Startup 
# Commands to execute on startup (before the prompt is shown)
# Check if the interactive shell option is set
# if [[ $- == *i* ]]; then
#    # This is a good place to load graphic/ascii art, display system information, etc.
#    if command -v pokego >/dev/null; then
#        pokego --no-title -r 1,3,6
#    elif command -v pokemon-colorscripts >/dev/null; then
#        pokemon-colorscripts --no-title -r 1,3,6
#     if command -v fastfetch >/dev/null; then
#         if do_render "image"; then
#             fastfetch --logo-type kitty
#         fi
#     fi
# fi

#   Overrides 
# HYDE_ZSH_NO_PLUGINS=1 # Set to 1 to disable loading of oh-my-zsh plugins, useful if you want to use your zsh plugins system
# unset HYDE_ZSH_PROMPT # Uncomment to unset/disable loading of prompts from HyDE and let you load your own prompts
# HYDE_ZSH_COMPINIT_CHECK=1 # Set 24 (hours) per compinit security check // lessens startup time
# HYDE_ZSH_OMZ_DEFER=1 # Set to 1 to defer loading of oh-my-zsh plugins ONLY if prompt is already loaded

if [[ ${HYDE_ZSH_NO_PLUGINS} != "1" ]]; then
    #  OMZ Plugins 
    # manually add your oh-my-zsh plugins here
    plugins=(
        "sudo"
        direnv
        dotnet
        vi-mode
    )
fi

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}

VI_MODE_SET_CURSOR=true
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
    for c in {a,i}{\',\",\`}; do
        bindkey -M $m $c select-quoted
    done
done

eval "$(zoxide init zsh)"
