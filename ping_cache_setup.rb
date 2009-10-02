require 'rubygems'
require 'dm-core'
require 'dm-validations'
search_me = ::File.expand_path(::File.join(::File.dirname(__FILE__), 'models', '*.rb'))
Dir.glob(search_me).sort.each {|rb| require rb}
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/pc_test.db")
DataMapper.auto_migrate!
Devices = {}
Locations = {}

  Devices[:iphone] = Device.create(:mac=>"0:13:72:3b:e2:99")
  Devices[:mac] = Device.create(:mac=>"0:18:8b:ab:d5:82")
  Locations[:ci] = Location.create(:ip=>"205.123.10.5", :name=>"collective intel")
  Locations[:the_cup] = Location.create(:ip=>"123.45.6.78", :name=>"The Cup")
