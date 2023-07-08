jellygtk_sources = [
  'main.vala',
  'application.vala',
]

jellygtk_deps = [
  dependency('gtk4'),
  dependency('libadwaita-1', version: '>= 1.2'),
  dependency ('libsoup-3.0'),
  dependency ('json-glib-1.0'),
  dependency ('gee-0.8'),
]

subdir('gtk')
subdir('api')

jellygtk_sources += gnome.compile_resources('jellygtk-resources',
  'jellygtk.gresource.xml',
  c_name: 'jellygtk'
)

executable('jellygtk', jellygtk_sources,
  dependencies: jellygtk_deps,
       install: true,
)
