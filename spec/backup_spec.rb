require 'spec_helper'
module ReversableDataMigration
  RAILS_ROOT = File.dirname(__FILE__)
end 
describe ReversableDataMigration do
  
  before :each do
    Product.delete_all
    `rm -rf #{File.dirname(__FILE__)}/db` 
    Product.create!(:state => "available")
    Product.create!(:state => "not_available")
  end

  it "should write backup data to a yml file with the name of the migration" do

    class RemoveStateFromProduct < ActiveRecord::Migration
      def self.up
        backup_data = []
        Product.all.each do |product|
          backup_data << {:id => product.id, :state => product.state}
        end
        backup backup_data
      end
    end

    RemoveStateFromProduct.up

    yaml = File.open( File.dirname(__FILE__) + "/db/migrate/backup_data/remove_state_from_product.yml" ) { |yf| YAML::load( yf ) }

    yaml.should == [
      {:id => 1, :state => "available"},
      {:id => 2, :state => "not_available"}
    ]
  end

  it "should write backup data to a yml file with the name given by the user" do

    class RemoveStateFromProduct < ActiveRecord::Migration
      def self.up
        backup_data = []
        Product.all.each do |product|
          backup_data << {:id => product.id, :state => product.state}
        end
        backup backup_data, "some_name"
      end
    end

    RemoveStateFromProduct.up

    yaml = File.open( File.dirname(__FILE__) + "/db/migrate/backup_data/some_name.yml" ) { |yf| YAML::load( yf ) }

    yaml.should == [
      {:id => 3, :state => "available"},
      {:id => 4, :state => "not_available"}
    ]
  end

  it "should rollback properly" do

    class RemoveStateFromProduct < ActiveRecord::Migration
      def self.up
        backup_data = []
        Product.all.each do |product|
          backup_data << {:id => product.id, :state => product.state}
        end
        backup backup_data
        remove_column :products, :state
      end

      def self.down
        add_column :products, :state, :string
        restore Product
      end
    end

    RemoveStateFromProduct.up
    RemoveStateFromProduct.down
  end
end