class Location
  
  include DataMapper::Resource
  property :id, Serial
  property :created_at, DateTime, :default => Proc.new {DateTime.now}
  property :updated_at, DateTime, :default => Proc.new {DateTime.now}
  property :mac, String
  property :name, String
  # has n, :users, :through => :device_locations => :device
  # has n, :devices, :through => :device_locations
  
  def users
    self.devices.collect{|d| d.users}.uniq
  end
  
end