#!/bin/bash

# say a word that you specify as an argument on the command-line
# it works via google translate 

# Note: if you get mplayer warnings "could not connect to socket" or "No such file or directory" on Ubuntu
#       see this solution: http://blog.timc3.com/2009/02/10/mplayer-disable-lirc/

say() { local IFS=+;/usr/bin/mplayer -ao alsa -really-quiet -noconsolecontrols "http://translate.google.com/translate_tts?tl=en&q=$*"; }
say $*
