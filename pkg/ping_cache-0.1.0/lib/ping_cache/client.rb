# this is the web ui that runs on client machines
# this ui is responsible for location setup 
# -> registering the location/locationMAC with the server
# -> seting up admin username/password for the location with the server and on the box
# -> kinda like a basic router setup

module PingCache
  class Client < Sinatra::Base
    set :static, true
    set :public, File.join(File.dirname(__FILE__), '..', '..', '/public')
    set :views, File.join(File.dirname(__FILE__), '..', '..', '/client_views')
    get '/' do
      erb :index
    end
  end
end