#!/usr/bin/env bash

get_page_description() {
  local desc page section
  page="$(echo "$1" | awk '{print $1}')"
  section="$(echo "$1" |awk '{print $2}' | sed 's#(\(.*\))#\1#' )"
  if [[ -n $section ]]; then
    desc="$(man "${section}" "${page}" 2>/dev/null | head -n 10)"
    # desc="$(whatis -l -s "${section}" "${page}")"
  else
    desc="$(man "${page}" 2>/dev/null | head -n 10 )"
    # desc="$(whatis -l "${page}")"
  fi
  # desc="$(echo "$desc" | head -n 1 | sed 's#^.* - ##')"
  
  echo "$desc"
}

get_page_description "$@"
