require 'rubygems'
require 'rake'
require 'echoe'
require 'rspec/core/rake_task'

task :default => :spec

Echoe.new('reversable_data_migrations', '0.1.0') do |p|
  p.description    = "Makes your data migrations reversable"
  p.url            = "http://github.com/tomkurt/reversable_data_migrations"
  p.author         = "Tom Maeckelberghe	"
  p.email          = "tom.Maeckelberghe@gmail.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }

RSpec::Core::RakeTask.new('spec')