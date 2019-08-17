## Cmus-notify

A cmus status notification program made for easy configuration and portability.

#### Requirements:

* cmus
* perl
* notify-send

#### Installation:

* `git clone https://github.com/dcx86r/cmus-notify`  
* install `HTML::Entities` module from CPAN
* `[sudo] sh installer.sh install`

...and to uninstall:  
* `[sudo] sh installer.sh uninstall`

#### Configuration:

Configuration is accomplished via file, which is installed to `/usr/share/cmus/notify.cfg`.  
Copy file to `~/.config/cmus` and modify to override default config. 

Possible config values:  

`file artist album duration title tracknumber date nomarkup`

Markup tags can be added by prepending config values with b, i, or u -- meaning bold, italicized, underlined.  
All can be used together, e.g. ibu:artist ui:title 

The default is to assume the notification application parses markup. If it does not, then `nomarkup` should be supplied in the config file.

#### Activate in cmus:

`:set status_display_program=/usr/local/bin/cmus_notify.sh`
