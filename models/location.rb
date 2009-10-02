class Location
  
  include DataMapper::Resource
  property :id, Serial
  property :ip, String
  property :created_at, DateTime, :default => Proc.new {DateTime.now}
  property :updated_at, DateTime, :default => Proc.new {DateTime.now}
  property :mac, String
  property :name, String
  # has n, :device_locations
  has n, :devices, :through => Resource
  
  def self.find_or_create(opts={})
    loc = Location.first(:ip=>opts[:ip])
    unless loc
      loc = Location.new(:ip=>opts[:ip]) 
      saved = loc.save
      if saved == false
        return loc.errors
      end
    end
    return loc
  end
  
  def tracks
    Tracker.all(:location_id=>self.id)
  end
  
end