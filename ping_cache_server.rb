require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-validations'

search_me = ::File.expand_path(::File.join(::File.dirname(__FILE__), 'models', '*.rb'))
Dir.glob(search_me).sort.each {|rb| require rb}

set :static, true
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/ttl.db")
ENV['RACK_ENV'] != 'production' ? DataMapper.auto_migrate! : DataMapper.auto_upgrade!

get '/' do
  erb :index
end

 get "/register/:mac" do
   #find or create device
   @device = Device.find_or_create(:mac=>params[:mac])
   #find or create location -> create should eventually be done by client
   @loc = Location.find_or_create(:ip=>@env['REMOTE_ADDR'])
   "Device: #{@device.inspect} Location: #{@loc.inspect}"
 end
 
 get '/locations' do 
   @locations = Location.all
   erb :locations
 end
 
 get '/devices' do
   @devices = Device.all
   erb :devices
 end
 
 get '/device_locations' do
   @device_locations = DeviceLocation.all
   erb :device_locations
 end