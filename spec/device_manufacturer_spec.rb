require File.join(File.dirname(__FILE__), %w[spec_helper])

describe "identifying devices" do
  it "should be able to determine the manufacturer" do
    Manufacturer.create(:mac=>"001372", :name=>"Fake Apple")    
    d = Device.create(:mac=>"0:13:72:ab:cd:12")
    d.manufacturer.should_not == nil
  end  
end