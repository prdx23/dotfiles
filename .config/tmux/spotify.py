import sys
import dbus

artist = 'Not Running'
album = ''
song = 'Spotify'

try:
    bus = dbus.SessionBus()
    proxy = bus.get_object(
        'org.mpris.MediaPlayer2.spotify', '/org/mpris/MediaPlayer2'
    )
    metadata = proxy.Get(
        'org.mpris.MediaPlayer2.Player',
        'Metadata',
        dbus_interface='org.freedesktop.DBus.Properties'
    )
    artist = ', '.join(metadata['xesam:artist'])
    album = metadata['xesam:album']
    song = metadata['xesam:title']
except dbus.exceptions.DBusException:
    pass


if len(sys.argv) > 1 and sys.argv[1] == 'artist':
    print(artist)
elif len(sys.argv) > 1 and sys.argv[1] == 'album':
    print(album)
elif len(sys.argv) > 1 and sys.argv[1] == 'song':
    print(song)
elif len(sys.argv) > 1:
    output = sys.argv[1]
    output = output.replace('[artist]', artist)
    output = output.replace('[album]', artist)
    output = output.replace('[song]', song)
    print(output)
