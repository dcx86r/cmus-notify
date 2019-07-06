#!/bin/sh

output=$(perl -CASDL /usr/local/bin/cmus-notify "$@")
summary=$(echo "$output" | head -n 1)
body=$(echo "$output" | tail -n +2)

notify-send	"$summary" "$body"
