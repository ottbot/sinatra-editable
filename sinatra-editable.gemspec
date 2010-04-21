require 'rake'

Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=

  s.name = 'sinatra-editable'
  s.version = '0.0.2'
  s.date = '2010-04-20'

  s.author = "Robert Crim"

  s.description = "A simple CMS extension for sinatra"
  s.summary     = "A simple CMS extension for sinatra"

  s.homepage = "http://github.com/ottbot/sinatra-editable"
  s.email = "robert@osbornebrook.co.uk"

  s.add_development_dependency 'sinatra'
  s.add_development_dependency 'redcloth'  
  
  s.files = FileList['lib/**/*.rb', 'bin/*', '[A-Z]*', 'test/**/*'].to_a
end
