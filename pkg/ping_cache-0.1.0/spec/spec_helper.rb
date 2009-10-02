require File.join(File.dirname(__FILE__), %w[.. lib ping_cache])

Spec::Runner.configure do |config|
  ENV['RACK_ENV'] ||= 'test'
  PingCache.initialize
  # PingCache.load_manufacturers
  PingCache.load_sample_data 
end

# EOF