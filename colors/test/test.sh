#!/usr/bin/env bash
set -euo pipefail

readonly MAX=10
name="world"
files=(a.txt b.txt "c d.txt")

# greet someone
greet() {
    local who="$1"
    echo "hello, ${who}!"
    return 0
}

add() {
    echo $(( $1 + $2 ))
}

for f in "${files[@]}"; do
    if [[ -f "$f" && ${#f} -lt $MAX ]]; then
        cat "$f" | grep -i "todo" | wc -l
    elif [ "$f" = "c d.txt" ]; then
        echo 'skip: $f'
    else
        echo "missing $f" >&2
    fi
done

i=0
while (( i < 3 )); do
    greet "$name"
    i=$((i + 1))
done

case "$name" in
    world) echo "default" ;;
    *) echo "other" ;;
esac

result=$(add 1 2)
echo "sum=$result" > /dev/null
