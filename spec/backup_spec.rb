require 'spec_helper'

describe ReversableDataMigration do
  
  before :each do
    Product.create!(:state => "available")
    Product.create!(:state => "not_available")
  end

  it "should have a location for the backup files" do
  end

end