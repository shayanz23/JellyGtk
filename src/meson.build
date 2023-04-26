jellyplayer_sources = [
  'main.vala',
  'application.vala',
  'window.vala',
  'signInWindow.vala',
]

jellyplayer_deps = [
  dependency('gtk4'),
  dependency('libadwaita-1', version: '>= 1.2'),
]

jellyplayer_sources += gnome.compile_resources('jellyplayer-resources',
  'jellyplayer.gresource.xml',
  c_name: 'jellyplayer'
)

executable('jellyplayer', jellyplayer_sources,
  dependencies: jellyplayer_deps,
       install: true,
)
