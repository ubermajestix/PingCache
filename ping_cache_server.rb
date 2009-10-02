require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-validations'

search_me = ::File.expand_path(::File.join(::File.dirname(__FILE__), 'models', '*.rb'))
Dir.glob(search_me).sort.each {|rb| require rb}

set :static, true
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/pc.db")
ENV['RACK_ENV'] != 'production_server' ? DataMapper.auto_upgrade! : DataMapper.auto_migrate!

get '/' do
  erb :index
end

 get "/register/:mac" do
   @device = Device.find_or_create(:mac=>params[:mac])
   # TODO reate should eventually be done by client web ui
   @loc = Location.find_or_create(:ip=>@env['REMOTE_ADDR'])
   @device.locations << @loc
   "Device: #{@device.mac} @ Location: #{@loc.ip}"
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