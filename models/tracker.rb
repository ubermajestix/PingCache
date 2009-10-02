class Tracker
  include DataMapper::Resource
  property :id, Serial 
  property :device_id,    Integer, :key => true
  property :location_id,      Integer, :key => true
  property :created_at, DateTime, :default => Proc.new {DateTime.now}
  # has n, :locations
  # has n, :devices
end