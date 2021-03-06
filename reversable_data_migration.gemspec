# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "reversible_data_migration"
  s.version     = File.open(File.expand_path("../VERSION", __FILE__)).read
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tom Maeckelberghe"]
  s.email       = ["tom.maeckelberghe@gmail.com"]
  s.homepage    = "https://github.com/tomkurt/reversible_data_migration"
  s.summary     = %q{Makes activerecord data migrations reversible.}
  s.description = %q{Backup data is saved to yaml files. The reverse process load the yaml and restores the records. Works for new and updates not for deletions.}
  
  s.add_development_dependency "rspec"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "activerecord", "2.3.14"

  s.rubyforge_project = "reversible_migration_helper"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end