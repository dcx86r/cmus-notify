## Cmus-notify

A cmus status notification program made for easy configuration and portability.

![Screenshot](https://raw.githubusercontent.com/dcx86r/dotfiles/master/ntfyscrt.jpg)

#### Requirements:

* cmus
* perl
* notify-send
* ffmpeg (optional)

#### Installation:

* `git clone https://github.com/dcx86r/cmus-notify`  
* install `HTML::Entities` module from CPAN
* `[sudo] sh installer.sh install`

...and to uninstall:  
* `[sudo] sh installer.sh uninstall`

If using a previous version, uninstall old version before installing new one

#### Configuration:

Configuration is accomplished via file, which is installed to `~/.config/cmus/notify.cfg`
on first run. The file is prepopulated with some default values that can be modified or
added to.

All possible config values:

`file artist album duration title tracknumber date nomarkup covers`

Markup tags can be added by prepending config values with b, i, or u -- meaning bold, italicized, underlined.  
All can be used together, e.g. ibu:artist ui:title. Markup tags do not apply to `nomarkup` or `covers`.

The default is to assume the notification application parses markup. If it does not, then `nomarkup` should be supplied in the config file.

#### Activate in cmus:

`:set status_display_program=/usr/local/bin/cmus-notify`

#### Notes

In general: errors are logged to `~/.config/cmus/notify.err`
Album art support:  
* `cmus-notify` uses `ffmpeg` to extract art from media files
* art is cached on disk at `~/.config/cmus/covers`
* the cache has no size limits imposed
* a placeholder image is shown if a file has no embedded art
* placeholder is also shown if art has not yet been cached (e.g. on first play 
of a file), this is because `ffmpeg` takes anywhere between 1-5+ seconds to
perform the extraction, so whatever is available is shown instead of waiting
an indeterminate amount of time
