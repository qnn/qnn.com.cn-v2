#!/bin/bash
set -e
PWD="`pwd`"
CONVERT=$(which convert)
IMAGES=($(find $PWD -maxdepth 1 -iregex '.*\.jpg$' -type f))

if [[ ! -d "${PWD}/150px" ]]; then
    mkdir "${PWD}/150px"
fi

for (( i=0; i<${#IMAGES[@]}; i++ )); do
    $CONVERT -resize 150x150^ -gravity center -extent 150x150 -- "${IMAGES[$i]}" "${IMAGES[$i]/$PWD/$PWD/150px}"
done
