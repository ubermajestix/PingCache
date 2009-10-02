module PingCache
  class Server < Sinatra::Base
    set :static, true
    set :public, File.join(File.dirname(__FILE__), '..', '..', '/public')
    set :views, File.join(File.dirname(__FILE__), '..', '..', '/server_views')
    get '/' do
      erb :index
    end

    get "/register/:mac/:local_ip/:local_name" do |mac, ip, name|
     begin
       # TODO reate should eventually be done by client web ui
       @loc = Location.find_or_create(:ip=>request.ip)
       @device = Device.find_or_create(:mac=>mac)
       @track = Tracker.create(:device_id=>@device.id, :location_id=>@loc.id, :local_ip=>ip, :local_name=>Rack::Utils.unescape(name))
       "Device: #{@device.mac} @ Location: #{@loc.ip} name: #{@track.local_name}"
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
     puts params[:device_id]
     @device = Device.get(params[:device_id])
     @device_locations = @device.tracks
     erb :device_tracker
    end

    get "/location/tracker/:location_id" do
     @location = Location.get(params[:location_id])
     @devices = @location.tracks
     erb :location_tracker
    end

    get '/device_locations' do
     @device_locations = Tracker.all
     erb :device_locations
    end
  end
end