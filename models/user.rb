class User
  
  include DataMapper::Resource
  property :id, Serial
  property :created_at, DateTime, :default => Proc.new {Time.now}
  property :updated_at, DateTime, :default => Proc.new {Time.now}
  property :email, String
  property :name, String
  has n, :devices
  
end