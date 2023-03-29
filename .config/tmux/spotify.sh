#!/bin/bash

icon='♫'

spotify-metadata() {
    dbus-send \
        --print-reply \
        --dest=org.mpris.MediaPlayer2.spotify \
        /org/mpris/MediaPlayer2 \
        org.freedesktop.DBus.Properties.Get \
        string:'org.mpris.MediaPlayer2.Player' \
        string:'Metadata'
}

song='spotify'
artist='not found'
album=''
sep='-'
# if spotify-metadata > /dev/null 2>&1 ; then
if pgrep -x "spotify" > /dev/null 2>&1 ; then
    song=$(spotify-metadata | grep -A 2 'title' | awk 'NR==2' | cut -d '"' -f 2)
    artist=$(spotify-metadata | grep -A 2 'artist' | awk 'NR==3' | cut -d '"' -f 2)
    album=$(spotify-metadata | grep -A 2 'album' | awk 'NR==2' | cut -d '"' -f 2)
    sep='by'
fi


if [[ $1 == 'song' ]]; then
    echo $song
elif [[ $1 == 'artist' ]]; then
    echo $artist
elif [[ $1 == 'album' ]]; then
    echo $album
elif [[ $1 == 'icon' ]]; then
    echo $icon
elif [[ $1 == 'sep' ]]; then
    echo $sep
elif [[ $1 == 'all' ]]; then
    spotify-metadata
fi
