#!/bin/bash

# set the url and search term here
url="https://www.google.com"
search_term="google"

base_url=$(echo "$url" | sed 's|[^/]*//||;s|/.*||')
visited=()
queue=("$url")
delimiter="=========================================================="

while [ ${#queue[@]} -ne 0 ]; do
    curr_url=${queue[0]}
    queue=("${queue[@]:1}")

    if [[ " ${visited[*]} " == *" $curr_url "* ]]; then
        continue
    fi

    visited+=("$curr_url")
    curr_url=$(echo "$curr_url" | sed 's/ /%20/g')
    echo "Crawling $curr_url ..."

    content=$(curl -s "$curr_url")

    if [ $? -ne 0 ]; then
        echo "Failed to download $curr_url"
        continue
    fi

    while IFS= read -r line; do
        if echo "$line" | grep -q "href="; then
            link=$(echo "$line" | sed 's/.*href="//;s/".*//')

            if echo "$link" | grep -q "^/"; then
                link="http://$base_url$link"
            fi

            if echo "$link" | grep -q "^http"; then
                if [[ "$link" == *"$base_url"* ]] && ! [[ " ${visited[*]} " == *" $link "* ]]; then
                    queue+=("$link")
                fi
            fi
        fi
    done <<< "$content"

    if echo "$content" | grep -q "$search_term"; then
        echo "$delimiter"
        echo "Search results for $curr_url:"
        echo "$delimiter"
        echo "$(echo "$content" | grep -n -B 1 -A 1 "$search_term")"
    fi
done