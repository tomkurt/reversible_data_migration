module ReversableDataMigration

  def location_backup_files
    "#{RAILS_ROOT}/db/migrate/backup_data"
  end
  
  def default_backupfile
    "#{location_backup_files}/#{name.underscore}.yml" # name.underscore => name of migration 
  end
  
  def full_path_of file
    "#{location_backup_files}/#{file}.yml"
  end
  
  def default_or_specific_file file
    if file
      full_path_of file
    else
      default_backupfile
    end
  end
  
  def backup data, file=nil
    unless File.directory?(location_backup_files)
      FileUtils.mkdir_p(location_backup_files)
    end
    file = default_or_specific_file(file)
    puts "-- writing backup data (#{data.count} records) to #{file}"
    File.open( file , 'w' ) do |out|
      YAML.dump( data, out ) 
    end
  end
  
  def destroy_created_records klass, file=nil
    file = default_or_specific_file(file)
    test_record = first_record(file)
    process_records(klass, file){ |object, object_hash| object.destroy }
    raise "Destroying objects failed" if test_record.blank? || test_record[:id].blank? || klass.find_by_id(test_record[:id]) 
  end
  
  def restore klass, file=nil
    file = default_or_specific_file(file)
    test_record = first_record file
    puts "-- restore data from #{file}"
    process_records(klass,file) do |object, object_hash|
      object_hash.select{|k,v| k != :id}.each do |key, value|
        object.send("#{key}=", value)
      end
      object.save
    end
  end

  def restore_batch
    @transaction = true
    @to_delete_after_transaction = []
    yield
    @to_delete_after_transaction.each do |file|
      delete_file(file) 
    end
  end  
    
  private
  
  def process_records klass, file
    count = 0
    File.open( file ) { |yf| YAML::load( yf ) }.each do |object_hash|
      object = klass.find object_hash[:id]
      yield object, object_hash
      count += 1
    end
    puts "-- processed #{count} records"
    unless @transaction
      delete_file(file) 
    else
      @to_delete_after_transaction << file
    end
  end
  
  def delete_file file
    puts "-- deleting backupfile #{file}"
    File.delete file 
  end
  
  def first_record file
    File.open( file ) { |yf| YAML::load( yf ) }.first
  end
  
end