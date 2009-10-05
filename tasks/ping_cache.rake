namespace :pc do
  task :env do
    PingCache.initialize
  end
  
  desc "load manufacturers"
  task :load_manu => :env do
    PingCache.load_manufacturers
  end
  
  desc "id device manufacturers"
  task :id_device => :env do
    @devices = Device.all(:manufacturer_id => nil)
    @devices.each{|d| d.get_manufacturer }
  end
end