#!/bin/sh
# Rebuild the small web fonts in assets/fonts from the app's full font files.
#
# Usage: tools/build-fonts.sh path/to/app/fonts
# Needs fontTools with brotli: pip install fonttools brotli
# Each font is cut down to the characters this site uses (Latin for Inter and Space
# Grotesk, Arabic letters and marks for Amiri) and saved as WOFF2. The SIL Open Font
# License allows this; the license texts are copied next to the fonts.
set -eu

here=$(cd "$(dirname "$0")/.." && pwd)
src=${1:?"Usage: $0 path/to/app/fonts"}
out="$here/assets/fonts"
mkdir -p "$out"

latin="U+0020-007E,U+00A0-00FF,U+0131,U+0152-0153,U+02BC,U+02C6,U+02DA,U+02DC,U+2013-2014,U+2018-201E,U+2022,U+2026,U+2032-2033,U+2039-203A,U+20AC,U+2122,U+2190-2193,U+2212"

pyftsubset "$src/Inter.ttf" --unicodes="$latin" \
  --layout-features='kern,liga,calt,ccmp,locl,mark,mkmk,tnum,case' \
  --flavor=woff2 --output-file="$out/Inter-subset.woff2"
pyftsubset "$src/SpaceGrotesk.ttf" --unicodes="$latin" \
  --layout-features='kern,liga,calt,ccmp,locl,mark,mkmk,tnum' \
  --flavor=woff2 --output-file="$out/SpaceGrotesk-subset.woff2"
pyftsubset "$src/Amiri-Regular.ttf" --unicodes="U+0020,U+0621-0652,U+0670,U+0640" \
  --layout-features='*' --flavor=woff2 --output-file="$out/Amiri-subset.woff2"

cp "$src/Inter-OFL.txt" "$src/SpaceGrotesk-OFL.txt" "$src/Amiri-OFL.txt" "$out/"
ls -l "$out"
