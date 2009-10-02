class Tracker
  include DataMapper::Resource
  property :id, Serial 
  property :device_id,    Integer, :key => true
  property :location_id,  Integer, :key => true
  property :local_ip,     String
  property :local_name,   String 
  property :created_at,   DateTime, :default => Proc.new {DateTime.now}
  belongs_to :location, :child_key=>[:location_id]
  belongs_to :device,   :child_key=>[:device_id] 
end