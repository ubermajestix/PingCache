class Device
  
  include DataMapper::Resource
  property :id, Serial
  property :user_id, Integer #pairing devices and users has to be somewhat definitive -> user must prove they have control of the device
  property :created_at, DateTime, :default => Proc.new {DateTime.now}
  property :mac, String
  has 1, :user
  has n, :device_locations
  has n, :locations, :through => :device_locations
  validates_is_unique :mac
  
  def self.find_or_create(opts={})
    device = Device.first(:mac=>opts[:mac])
    unless device
      device = Device.new(:mac=>opts[:mac]) 
      saved = device.save
      if saved == false
        return device.errors
      end
    end
    return device
  end
  
  def tracks
    Tracker.get(:device_id=>self.id)
  end
end