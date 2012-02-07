require "reversable_data_migration"
ActiveRecord::Migration.send(:extend, ReversableDataMigration)