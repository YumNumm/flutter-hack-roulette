#!/bin/bash

# See: https://github.com/yumemi-inc/flutter-mobile-project-template/blob/6ecefcaeb994ed2ec6bd61341d9e59988167c940/apps/app/ios/scripts/extract_dart_defines.sh

set -euo pipefail

OUTPUT_FILE="${SRCROOT}/Flutter/Environment.xcconfig"
> "$OUTPUT_FILE"

decode_url() { echo "${*}" | base64 --decode; }

IFS=',' read -r -a define_items <<<"$DART_DEFINES"

for index in "${!define_items[@]}"
do
    item=$(decode_url "${define_items[$index]}")
    uppercase_item=$(echo "$item" | tr '[:lower:]' '[:upper:]')
    if [[ $uppercase_item != FLUTTER* ]]; then
        echo "Extracting environment variable: $item"
        echo "$item" >> "$OUTPUT_FILE"
    fi
done
