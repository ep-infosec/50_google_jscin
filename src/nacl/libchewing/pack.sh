#!/bin/sh
set -e
OUTPUT=../../jscin_chewing.zip
NACL=nacl
NACL_OLD=

trap cleanup EXIT

cleanup() {
  if [ -n "$NACL_OLD" -a -e "$NACL_OLD" ]; then
    rm -f $NACL
    mv -f $NACL_OLD $NACL
  fi
}

die () {
  echo "ERROR: $*"
  exit 1
}

if [ -e $NACL ]; then
  NACL_OLD=.nacl.old
  rm -f "$NACL_OLD"
  mv "$NACL" "$NACL_OLD"
fi

make CONFIG=Release
ln -s newlib/Release "$NACL"
rm -f $OUTPUT
SRCS=$(echo background.{html,js} options.{html,js} jscin.ext/* \
       jquery/*.js jquery/css/*.css \
       manifest.json _locales/*/*.json \
       libchewing/data/*.{dat,tab} $NACL/chewing.nmf $NACL/chewing_[ax]*.nexe)
for file in $SRCS; do
  [ -f "$file" ] || die "Failed to find $file".
done
zip -r $OUTPUT $SRCS
