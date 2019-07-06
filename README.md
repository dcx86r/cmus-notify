## Summary

A cmus status notification program made for easy configuration and portability.

#### Requirements:

* cmus
* perl
* notify-send

#### Installation:

`git clone ...`
`[sudo] sh installer.sh install`

...and to uninstall: 
`[sudo] sh installer.sh uninstall`

#### Configuration:

Configuration is accomplished via file, which is installed to `/usr/share/cmus/notify.cfg`.  
Copy file to `~/.config/cmus` and modify to override default config.

Possible config values:  

`file, arist, album, duration, title, tracknumber, date`

Markup tags can be added by prepending config values with b, i, or u -- meaning bold, italicized, underlined.  
two or all can be used together, e.g. ibu:artist ui:title 

#### Activate in cmus:

`:set status_display_program=/usr/local/bin/cmus_notify.sh`
