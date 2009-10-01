puts ENV['RACK_ENV']
if ENV['RACK_ENV'].include?('server')
  require 'ping_cache_server'
elsif ENV['RACK_ENV'].include?('client')
  require 'ping_cache_client'
end
run Sinatra::Application