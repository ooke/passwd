#!/bin/sh

if [ $# -ne 2 ]; then
    echo "Usage: $0 <config> <destination>" >&2
    exit 1
fi

CONFFILE="$1"
DIR="${2%/}"
[ -f "$CONFFILE" ] || { echo "Config gile '$CONFFILE' not found." >&2; exit 1; }
[ -d "$DIR" ] || { echo "Directory '$DIR' not found." >&2; exit 1; }
for FNAME in css/bootstrap.min.css \
             css/bootstrap-theme.min.css \
             css/bootstrap.ss.min.css \
             css/bootstrap-theme.ss.min.css \
             fonts/glyphicons-halflings-regular.eot \
             fonts/glyphicons-halflings-regular.svg \
             fonts/glyphicons-halflings-regular.ttf \
             fonts/glyphicons-halflings-regular.woff \
             fonts/glyphicons-halflings-regular.woff2 \
             index.html \
             js/bootstrap.min.js \
             js/dict.js \
             js/jquery.min.js \
             js/main.js \
             js/npm.js \
             js/otp.js \
             js/sha1.js \
             manifest.json \
             browserconfig.xml \
             android-chrome-192x192.png \
             android-chrome-512x512.png \
             apple-touch-icon.png \
             favicon-16x16.png \
             favicon-32x32.png \
             favicon.ico \
             mstile-144x144.png \
             mstile-150x150.png \
             mstile-310x150.png \
             mstile-310x310.png \
             mstile-70x70.png \
             safari-pinned-tab.svg
do
    SUBDIR="`dirname "$FNAME"`"
    [ -d "$DIR/$SUBDIR" ] || mkdir -p "$DIR/$SUBDIR" || {
        echo "Creation of directory '$DIR/$SUBDIR' failed." >&2
        exit 2;
    }
    if [ "$FNAME" = "js/main.js" -o "$FNAME" = "index.html" ]; then
        FNAMEIN="${FNAME}.result"
        cat "$CONFFILE" "$FNAME" | m4 - >"$FNAMEIN"
    else
        FNAMEIN="$FNAME"
    fi
    diff -q "$DIR/$FNAME" "$FNAMEIN" 2>/dev/null || cp -v "$FNAMEIN" "$DIR/$FNAME" || {
        echo "Copy of file '$FNAME' to directory '$DIR' failed." >&2
        exit 3;
    }
done

exit 0
