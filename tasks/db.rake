require 'rubygems'
require 'lib/ping_cache'
namespace :db do
  
  task :env do
    PingCache.initialize
  end
  
  desc "migrate"
  task :migrate => :env do
    DataMapper.auto_migrate!
  end

end