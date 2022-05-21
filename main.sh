#!/bin/bash

#export PROXIES='[
#    { "source": "6000", "target": "127.0.0.1:7009" },
#    { "source": "7000", "target": "127.0.0.1:7009" }
#]'

if [[ -z $PROXIES ]]
then
    PROXIES="[]"
fi

for J in $(echo $PROXIES | jq -c '.[] | .'); do
    SOURCE=$(echo $J | jq -r .source)
    TARGET=$(echo $J | jq -r .target)
    eval "socat TCP4-LISTEN:$SOURCE,fork,reuseaddr TCP4:$TARGET &"
done

jobs
wait