#!/bin/bash
# REQS - pandoc
# evertyhing else should be in bash coreutils

# sets timestamp for todays date
timestamp=$(date +"%m-%d-%y")
# fetches url and saves to file
curl [$URL] >> "$timestamp".html -s

# Check if Pandoc is installed
if ! command -v pandoc &> /dev/null; then
    echo "Error: 'pandoc' is not installed." >&2
    echo "Please install it using your package manager (e.g., 'brew install pandoc' or 'sudo apt install pandoc')." >&2
    exit 1
fi
# Run Pandoc conversion
pandoc -f html -t markdown --wrap=none "$timestamp".html -o "$timestamp".md
rm "$timestamp".html

# searches for regex before interesting stuff
before=$(grep -n '[$START_PATTERN]' "$timestamp".md | cut -f1 -d:| head -1)
# searches for regex after interesting stuff
after=$(grep -n '[$END_PATTERN]' "$timestamp".md | cut -f1 -d:| head -1)
# gets line count of file
lines=$(wc -l < "$timestamp".md)
# cuts uninteresting parts of file
sed -i "${after},${lines}d" "$timestamp".md
sed -i "1,${before}d" "$timestamp".md

# checks for baseline file existing. Makes one if not
[ -f "baseline.md" ] || { echo "No baseline file. Making file now..."; cp "$timestamp".md baseline.md; rm "$timestamp".md ;exit 1; }

# actual diff time. If there's a difference, prints nicely-formatted output and makes this the new "baseline" file. Otherwise states there's no diff
diffFiles(){
    output="$(diff baseline.md "$timestamp".md --suppress-common-lines -y --color)"
    if [[ -n $output ]]
    then
        printf -- "%s\n" "$output"
        cp "$timestamp".md baseline.md
        rm "$timestamp".md
    else
        printf -- "No changes since last check!\n"
        rm "$timestamp".md
    fi
}
diffFiles
