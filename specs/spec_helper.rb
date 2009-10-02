require File.join(File.dirname(__FILE__), %w[.. ping_cache_setup])

Spec::Runner.configure do |config|
  DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/pc_test.db")
  DataMapper.auto_migrate!
  Devices = {}
  Locations = {}
  def sample_data
    Devices[:iphone] = Device.create(:mac=>"0:13:72:3b:e2:99")
    Devices[:mac] = Device.create(:mac=>"0:18:8b:ab:d5:82")
    Locations[:ci] = Location.create(:ip=>"205.123.10.5", :name=>"collective intel")
    Locations[:the_cup] = Location.create(:ip=>"123.45.6.78", :name=>"The Cup")
    # dl = DeviceLocation.new(:device=>Devices[:mac], :location=>Locations[:ci])
    # puts dl.errors.inspect
  end
  sample_data
end

# EOF