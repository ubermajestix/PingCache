require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-validations'

search_me = ::File.expand_path(::File.join(::File.dirname(__FILE__), 'models', '*.rb'))
Dir.glob(search_me).sort.each {|rb| require rb}

set :static, true
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/pc.db")
ENV['RACK_ENV'] == 'production_server' ? DataMapper.auto_upgrade! : DataMapper.auto_migrate!

get '/' do
  erb :index
end

 get "/register/:mac" do
   begin
     # TODO reate should eventually be done by client web ui
     @loc = Location.find_or_create(:ip=>request.ip.to_s)
     @device = Device.find_or_create(:mac=>params[:mac])
     # TODO this works local not in prod...?
     # @device.locations << @loc
     #     @device.save
     Tracker.create(:device_id=>@device.id, :location_id=>@loc.id)
     "Device: #{@device.mac} @ Location: #{@loc.ip}"
   rescue StandardError => e
     "Error: #{e.class} => #{e.message} \n #{e.backtrace.join("\n")}"
   end
 end
 
 get '/locations' do 
   @locations = Location.all
   erb :locations
 end
 
 get '/devices' do
   @devices = Device.all
   erb :devices
 end
 
 get "/device/tracker/:device_id" do
   @device = Device.get(:id=>params[:device_id])
   @device_locations = @device.tracks
   erb :device_tracker
 end
 
 get "/location/tracker/:locaiton_id" do
   @location = Location.get(:id=>params[:location_id])
   @devices = @location.tracks
   erb :location_tracker
 end
 
 get '/device_locations' do
   @device_locations = DeviceLocation.all
   erb :device_locations
 end