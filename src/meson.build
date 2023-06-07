jellyplayer_sources = [
  'main.vala',
  'application.vala',
]

jellyplayer_deps = [
  dependency('gtk4'),
  dependency('libadwaita-1', version: '>= 1.2'),
  dependency ('libsoup-3.0'),
  dependency ('json-glib-1.0'),
]

subdir('gtk')
subdir('api')

jellyplayer_sources += gnome.compile_resources('jellyplayer-resources',
  'jellyplayer.gresource.xml',
  c_name: 'jellyplayer'
)

executable('jellyplayer', jellyplayer_sources,
  dependencies: jellyplayer_deps,
       install: true,
)
