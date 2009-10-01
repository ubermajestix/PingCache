# this is the web ui that runs on client machines
# this ui is responsible for device setup 
# -> registering the location/deviceMAC with the server
# -> seting up admin username/password for the location with the server and on the box
# -> kinda like a basic router setup
require 'rubygems'
require 'sinatra'
require 'dm-core'

get '/' do
  erb :index
end