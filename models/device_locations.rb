class DeviceLocations
  include DataMapper::Resource
  property :id, Serial 
  property :device_id,    Integer, :key => true
  property :locaction_id,      Integer, :key => true
  property :created_at, DateTime, :default => Proc.new {Time.now}
  belongs_to :device,   :child_key=>[:device_id]
  belongs_to :location, :child_key=>[:location_id]  
end