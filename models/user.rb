class User
  
  include DataMapper::Resource
  property :id, Serial
  property :created_at, DateTime, :default => Proc.new {DateTime.now}
  property :updated_at, DateTime, :default => Proc.new {DateTime.now}
  property :email, String
  property :name, String
  has n, :devices
  
end