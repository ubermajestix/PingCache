class Location
  
  include DataMapper::Resource
  property :id, Serial
  property :ip, String
  property :created_at, DateTime, :default => Proc.new {DateTime.now}
  property :updated_at, DateTime, :default => Proc.new {DateTime.now}
  property :mac, String
  property :name, String
  # has n, :users, :through => :device_locations => :device
  # has n, :devices, :through => :device_locations
  
  def users
    self.devices.collect{|d| d.users}.uniq
  end
  
  def self.find_or_create(opts={})
    loc = Location.first(:ip=>opts[:ip])
    unless device
      loc = Location.new(:ip=>opts[:ip]) 
      saved = loc.save
      if saved == false
        return loc.errors
      end
    end
    return loc
  end
  
end