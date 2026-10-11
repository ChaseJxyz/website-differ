# website-differ
Bash script to help automate scraping/monitoring websites - now with Anubis bypass!

## Dependencies

This only needs pandoc and curl-impersonate, but everything else is in coreutils

## Function

Since I built this to monitor a specific webpage, the parameters are currently hard-coded, but I'll update this later to allow input from other sources. This webpage was also...strange, where the content I was interested in (an unordered list) was coded as a single line in the original HTML. Hence the conversion to Markdown first. They also enabled Anubis shortly after I made this script; it has since been updated to get around that.

## Process

The target URL is pulled via curl-impersonate and passing an Anubis auth cookie and written to an HTML file. This file is then checked if it is a "wall" made by Anubis. If so, it exists the script at this point. Otherwise, it's then converted to Markdown. The file is searched for patterns to find the start/end of the "interesting" parts you'd want to track and the boring bits are cut out. I used HTML/Markdown headers, but you can put in whatever you like. I did this so I wouldn't get "false positives" from things like website banners, footers, and topnavs changing.

The script checks for "baseline.md", which would have been made by this script running previously. If it can't find one, it turns the current file into the baseline and closes. If the baseline exists, it runs a diff and prints a (somewhat) pretty version of the output, if available. If there's a change, the current file is turned into the new baseline. If there's no changes, it states as such. Regardless, the script cleans up after itself and deletes the other files, so all that's left over is baseline.md.

## Use

Save locally and make sure to chmod +x. Navigate to the target webpage and pass the Anubis challenge, if any. Export the cookies from the webpage. Edit the file with the URL of your target (line 14) and the cookie file (line 14). If your site doesn't use Anubis, comment out/remove lines 16-23, edit line 14 to remove `-b {$URL}_cookies.txt`.

If you want to cut out headers/footers, edit lines 35 and 37 with the correct patterns. If you don't want to bother with that, comment out/remove lines 34-43.

Feel free to use edit etc. Just don't use this for homework/classwork and pretend you made it yourself.
