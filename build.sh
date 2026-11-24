#!/usr/bin/env bash
set -eu

usage() {
  printf 'Usage: %s [--preview]\n' "${0##*/}"
  printf '  Build the full Quarto site into docs/.\n'
  printf '  --preview  Build the site and open a live local preview.\n'
}

if (( $# > 1 )); then
  usage >&2
  exit 2
fi

case "${1:-}" in
  '') set -- render ;;
  --preview) set -- preview --render all ;;
  -h|--help) usage; exit 0 ;;
  *) usage >&2; exit 2 ;;
esac

if ! command -v quarto >/dev/null 2>&1; then
  printf 'Quarto is required. Install it and make sure quarto is on your PATH.\n' >&2
  exit 127
fi

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
exec quarto "$@"
