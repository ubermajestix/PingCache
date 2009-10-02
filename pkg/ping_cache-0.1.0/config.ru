require 'rubygems'
require 'lib/ping_cache'

class PingCacheServer < PingCache::Server    
  PingCache.initialize
  # PingCache.initialize(:environment=>ENV['RACK_ENV'] || "development")
end

class PingCacheClient < PingCache::Client   
  PingCache.initialize
  # PingCache.initialize(:environment=>ENV['RACK_ENV'] || "development")
end

if ENV['RACK_ENV'].include?('server')
  run PingCacheServer.new
elsif ENV['RACK_ENV'].include?('client')
  run PingCacheClient.new
end
