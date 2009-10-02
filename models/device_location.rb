class DeviceLocation
  include DataMapper::Resource
  property :id, Serial 
  property :device_id,    Integer, :key => true
  property :location_id,      Integer, :key => true
  property :created_at, DateTime, :default => Proc.new {DateTime.now}
  belongs_to :device,   :child_key=>[:device_id]
  belongs_to :location, :child_key=>[:location_id]  
end