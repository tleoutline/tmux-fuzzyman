#!/usr/bin/env sh

get_page_description() {
  local desc page
  page="$(echo $1 | sed 's/\s\+//')"
  desc="$(MANWIDTH=$FZF_PREVIEW_COLUMNS man "${page}" 2&> /dev/null)" 
  echo "$desc"
}

get_page_description "$@"
