Gem::Specification.new do |s|
  s.name         = 'perhoa'
  s.version      = '0.0.1'
  s.date         = '2017-08-03'
  s.summary      = 'Personal Home Assistent'
  s.description  = <<ENDDESCRIPTION
  A personal home assistent to help wake you up, remind you of things to do, and more things to come
ENDDESCRIPTION
  s.author       = 'Keeyan Nejad'
  s.files = Dir['Rakefile', '{bin,lib,assets,test}/**/*', 'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")
  s.email        = 'keeyan@knejad.co.uk'
  s.homepage     = 'https://github.com/KNejad/perhoa'
  s.license      = 'AGPL-3.0'
  s.require_paths = ['lib']
  s.executables = ['perhoa']
end
