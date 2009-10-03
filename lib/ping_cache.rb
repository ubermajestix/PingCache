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
      init_db()
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
    # TODO rebuild yaml file, load into sql from oui.txt
    
    def load_manufacturers
      t = File.open("#{Dir.pwd}/lib/oui.txt"){|f| f.read}.split("\n")
      m = t.collect{|e| e.split("(hex)")}
      m.reject!{|e| e.length < 2}
      # Character encoding issue on postgres
      m.each{|e| Manufacturer.create(:mac=>e.first.strip.gsub("-",'').downcase, :name=>e.last.strip)}
    end
    
    
    def devices
      {}
    end
    
    def locations
      {}
    end
    
    def init_db
      if ENV['RACK_ENV'] == 'production_server'       
        #heroku postgres server...
        DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db/pc.db")
        DataMapper.auto_upgrade!
      elsif ENV['RACK_ENV'] == 'production_client'
        DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db/pc_client.db")
        DataMapper.auto_upgrade!
        #heroku postgres server...
      elsif ENV['RACK_ENV'] == 'test'
        DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db/pc_test.db")  
        DataMapper.auto_migrate!     
      else
        puts "starting ping cache in #{ENV['RACK_ENV']} mode"
        puts "opening sqlite3://#{Dir.pwd}/db/pc_test.db"
        DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db/pc.db")
      end
      DataMapper.auto_upgrade! # use rake task db:migrate to blow away data and start over
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