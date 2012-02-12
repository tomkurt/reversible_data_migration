require 'rubygems'
require 'bundler/setup'
require 'sqlite3'
require 'active_record'
class Rails
  def self.version
  	"2"
  end
end
require 'reversable_data_migration'

RSpec.configure do |config|
  
end



# connect to database.  This will create one if it doesn't exist
MY_DB_NAME = ".test.db"
`rm #{MY_DB_NAME}`
MY_DB = SQLite3::Database.new(MY_DB_NAME)

# get active record set up
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => MY_DB_NAME)

# create your AR class
class Product < ActiveRecord::Base

end

# do a quick pseudo migration.  This should only get executed on the first run
if !Product.table_exists?
  ActiveRecord::Base.connection.create_table(:products) do |t|
    t.column :state, :string
  end
end

$stdout = File.new('/dev/null', 'w')