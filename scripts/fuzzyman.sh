#!/usr/bin/env bash

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
    --tmux center
    --preview="${TMUX_PLUGIN_MANAGER_PATH%/}/tmux-fuzzyman/scripts/preview.sh {}"
    --preview-window="top,wrap"
  )
  man_pages="$(apropos . | awk -F- '{print $1}')"
  selected="$(echo "$man_pages" | fzf "${fzf_args[@]}" | sed 's#^\(.*\) (\(.*\))#\1.\2#')"
  tmux splitw -h "echo $selected | xargs man"
}

get_man_pages
