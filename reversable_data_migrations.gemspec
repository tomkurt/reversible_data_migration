# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "reversable_data_migrations"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tom Maeckelberghe\t"]
  s.date = "2012-02-07"
  s.description = "Makes your data migrations reversable"
  s.email = "tom.Maeckelberghe@gmail.com"
  s.extra_rdoc_files = ["README.rdoc", "lib/reversable_data_migration.rb"]
  s.files = ["README.rdoc", "Rakefile", "lib/reversable_data_migration.rb", "Manifest", "reversable_data_migrations.gemspec"]
  s.homepage = "http://github.com/tomkurt/reversable_data_migrations"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Reversable_data_migrations", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "reversable_data_migrations"
  s.rubygems_version = "1.8.10"
  s.summary = "Makes your data migrations reversable"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
