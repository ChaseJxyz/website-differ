# website-differ
Bash script to help automate scraping/monitoring websites

## Dependencies

This only needs pandoc, but everything else is in coreutils

## Function

Since I built this to monitor a specific webpage, the parameters are currently hard-coded, but I'll update this later to allow input from other sources. This webpage was also...strange, where the content I was interested in (an unordered list) was coded as a single line in the original HTML. Hence the conversion to Markdown first.

## Process

The target URL is pulled via curl and written to an HTML file, which is then converted to Markdown (or an error message is displayed if pandoc is not installed). The file is searched for patterns to find the start/end of the "interesting" parts you'd want to track and the boring bits are cut out. I used HTML/Markdown headers, but you can put in whatever you like. I did this so I wouldn't get "false positives" from things like website banners, footers, and topnavs being changed.

The script checks for "baseline.md", which would have been made by this script running previously. If it can't find one, it turns the current file into the baseline and closes. If the baseline exists, it runs a diff and prints a (somewhat) pretty version of the output, if available. If there's a change, the current file is turned into the new baseline. If there's no changes, it states as such. Regardless, the script cleans up after itself and deletes the other files, so all that's left over is baseline.md.

## Use

Save locally and make sure to chmod +x. You'll need to edit lines 8, 21, and 23 to the URL/patterns you want to search for (or just delete lines 20-28 if you're fine with getting false positives). If you want your baseline.md file to exist somewhere other than the same folder as this script, then edit line 31 (in two spots), 35, and 39.

Feel free to use edit etc. Just don't use this for homework/classwork and pretend you made it yourself.
