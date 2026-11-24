#!/bin/sh
# Re-copy the app screenshots used on the landing page and shrink them for the web.
#
# Usage: tools/refresh-screens.sh path/to/app/screenshot/gallery
# Needs ImageMagick (`magick`). Output: assets/screens/<name>.jpg, 780 px wide, JPEG.
#
# Four screenshots are trimmed at the bottom (height in px after resizing to 780 wide):
# the tab bar is cut from home and the two Quran pages, and only the first layer row is
# kept on the notes page, so the images show only what the test version offers.
# If the app's layout changes, check these heights and the width/height attributes in index.html.
set -eu

here=$(cd "$(dirname "$0")/.." && pwd)
src=${1:?"Usage: $0 path/to/screenshot/gallery"}
out="$here/assets/screens"
width=780
quality=74

# name:height (0 = keep the full height)
specs="home:1508 reader-memorize:1516 reader-hidden:1516 notes-page:1550 call-teacher:1694"

[ -d "$src" ] || { echo "No gallery folder at $src" >&2; exit 1; }
mkdir -p "$out"

for spec in $specs; do
  n=${spec%%:*}
  h=${spec##*:}
  in="$src/$n.png"
  [ -f "$in" ] || { echo "Missing $in" >&2; exit 1; }
  if [ "$h" -gt 0 ]; then crop="-crop ${width}x${h}+0+0 +repage"; else crop=""; fi
  # shellcheck disable=SC2086
  magick "$in" -resize "${width}x" $crop -strip -sampling-factor 4:2:0 -quality "$quality" "$out/$n.jpg"
  size=$(wc -c < "$out/$n.jpg" | tr -d ' ')
  echo "$n.jpg  $(magick identify -format '%wx%h' "$out/$n.jpg")  ${size} bytes"
done
