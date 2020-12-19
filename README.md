## Cmus-notify

A cmus status notification program made for easy configuration and portability.

![Screenshot](https://raw.githubusercontent.com/dcx86r/cmus-notify/master/2020-12-18-a85d.jpg)

#### Requirements:

* cmus
* perl
* notify-send
* ffmpeg (optional)
* PerlMagick (optional)

#### Installation:

* `git clone https://github.com/dcx86r/cmus-notify`  
* install `HTML::Entities` module from CPAN
* `[sudo] sh installer.sh install`

...and to uninstall:  
* `[sudo] sh installer.sh uninstall`

If using a previous version, uninstall old version before installing new one

#### Configuration:

Configuration is accomplished via file, which is installed to `$HOME/.config/cmus/notify.cfg`
on first run. The file is prepopulated with some default values that can be modified or
added to.

The default config values:

`artist i:title duration`

All possible config values:

`file artist album duration title tracknumber date nomarkup covers`

Album art is not shown by default, adding the value `covers` to the config file enables that option.

Markup can be used by prepending config values with b, i, or u -- meaning bold, italicized, underlined.  
All can be used together, e.g. ibu:artist ui:title. Markup tags do not apply to `nomarkup` or `covers`.

The default is to assume the notification application parses markup. If it does not, then `nomarkup` should be supplied in the config file.

#### Activate in cmus:

`:set status_display_program=/usr/local/bin/cmus-notify`

#### Rounding corners

In order to use the functionality to round corners on album art, PerlMagick must be installed first.  

With PerlMagick installed, the `covers` option in the config file must be appended with two values:

1. image size
2. corner radius

The image size setting should match the expected size shown in the notification application (e.g. 64, 128).  
For example, `covers:128:8` sets the image size to 128px and the corner radius to 8.

#### Notes

In general: errors are logged to `$HOME/.local/share/cmus-notify/error.log`

Album art support:  
* `cmus-notify` uses `ffmpeg` to extract art from media files
* art is cached on disk at `$HOME/.local/share/cmus-notify/covers`
* the cache has no size limits imposed
* a placeholder image is shown if a file has no embedded art
* placeholder is also shown if art has not yet been cached (e.g. on first play 
of a file), this is because `ffmpeg` takes anywhere between 1-5+ seconds to
perform the extraction, so whatever is available is shown instead of waiting
an indeterminate amount of time
