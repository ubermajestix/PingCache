class Manufacturer  
  include DataMapper::Resource
  property :id, Serial
  property :mac, String
  property :name, String
  property :created_at, DateTime, :default => Proc.new {DateTime.now}
  property :updated_at, DateTime, :default => Proc.new {DateTime.now}
  has n, :devices
end