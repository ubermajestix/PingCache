class Device
  
  include DataMapper::Resource
  property :id, Serial
  property :user_id, Integer #pairing devices and users has to be somewhat definitive -> user must prove they have control of the device
  property :created_at, DateTime, :default => Proc.new {Time.now}
  property :mac, String
  has 1, :user
  # has n, :locations, :through => :device_locations
  validates_is_unique :mac
  
  def self.find_or_create(opts={})
    puts "finding or creating #{opts[:mac]}"
    device = Device.first(:mac=>opts[:mac])
    unless device
      device = Device.new(:mac=>opts[:mac]) 
      saved = device.save
      puts "created: #{saved}"
      if saved == false
        puts device.errors.inspect
      end
    end
    puts device.inspect
    puts "=="*45
    return device
  end
end