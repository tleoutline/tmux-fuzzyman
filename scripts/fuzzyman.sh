#!/usr/bin/env sh

tmux_option_or_fallback() {
	local option_value
	option_value="$(tmux show-option -gqv "$1")"
	if [ -z "$option_value" ]; then
		option_value="$2"
	fi
	echo "$option_value"
}

get_man_pages() {
  local man_pages fzf_args selected
  fzf_args=(
    --tmux "center,60%,80%"
    --preview="${TMUX_PLUGIN_MANAGER_PATH%/}/tmux-fuzzyman/scripts/preview.sh {}"
    --preview-window="top,70%,wrap"
    --bind "ctrl-u:half-page-up"
    --bind "ctrl-d:half-page-down"
    --bind "pgup:preview-half-page-up"
    --bind "pgdn:preview-half-page-down"
    --header "ctrl-u: 󰅃 / ctrl-d: 󰅀 / pg-up: preview 󰅃 / pg-down: preview 󰅀"
    --preview-label "man pages"
  )
  man_pages="$(apropos . | awk -F " +- +" '{print $1}')"
  selected="$(echo "$man_pages" | fzf "${fzf_args[@]}" | sed 's/\s\+//')"
  if [ -n "$selected" ]; then
    tmux splitw -h "if command -v zsh >/dev/null 2>&1; then zsh -i -c 'man \"$selected\"'; else man \"$selected\"; fi"
  fi
}

get_man_pages
