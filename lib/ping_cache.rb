require 'rubygems'
require 'dm-core'
require 'dm-validations'
require 'yaml'
require 'sinatra/base'
search_me = ::File.expand_path(::File.join(::File.dirname(__FILE__), '..', 'models', '*.rb'))
Dir.glob(search_me).sort.each {|rb| require rb}
module PingCache
  class << self
    def initialize
      if ENV['RACK_ENV'] == 'production_server'
        DataMapper.auto_upgrade!
        #heroku postgres server...
      elsif ENV['RACK_ENV'] == 'production_client'
        DataMapper.auto_upgrade!
        #heroku postgres server...
      else
        puts "starting ping cache in #{ENV['RACK_ENV']} mode"
        puts "opening sqlite3://#{Dir.pwd}/db/pc_test.db"
        DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db/pc_test.db")
        DataMapper.auto_migrate!
      end
      return nil      
    end
    public :initialize

    def server_app
      puts "server apping away"
      @app ||= Rack::Builder.new do
        use Rack::Session::Cookie, :key => 'rack.session', :path => '/',
         :expire_after => 2592000, :secret => ::Digest::SHA1.hexdigest(Time.now.to_s)
        run Server
      end
    end
  
    def client_app
      puts "client apping away"
      @app ||= Rack::Builder.new do
        use Rack::Session::Cookie, :key => 'rack.session', :path => '/',
         :expire_after => 2592000, :secret => ::Digest::SHA1.hexdigest(Time.now.to_s)
        run Client
      end
    end
    
    def require_all_libs_relative_to( fname, dir = nil )
      dir ||= ::File.basename(fname, '.*')
      search_me = ::File.expand_path(
          ::File.join(::File.dirname(fname), dir, '**', '*.rb'))
      Dir.glob(search_me).sort.each{|rb| puts "require #{rb}"}
      Dir.glob(search_me).sort.each {|rb| require rb}
    end  
  
    def load_manufacturers
      puts "loading manufacturers table"
      macs = YAML.load_file( "#{Dir.pwd}/lib/manufacturers.yml" )
      macs.each{|m| Manufacturer.create(:mac=>m.first, :name=>m.last)}
    end
    
    def devices
      {}
    end
    
    def locations
      {}
    end
    
    def load_sample_data
      Devices[:iphone] = Device.create(:mac=>"0:13:72:3b:e2:99")
      Devices[:mac] = Device.create(:mac=>"0:18:8b:ab:d5:82")
      Locations[:ci] = Location.create(:ip=>"205.123.10.5", :name=>"collective intel")
      Locations[:the_cup] = Location.create(:ip=>"123.45.6.78", :name=>"The Cup")
    end
  end #class << self
end
PingCache.require_all_libs_relative_to(__FILE__)
Devices = PingCache.devices
Locations = PingCache.locations