require File.join(File.dirname(__FILE__), %w[spec_helper])

describe "log device at location at time" do
  
  it "should be able to add location to device" do
    d = Devices[:iphone]
    d.locations.length.should == 0
    d.locations << Locations[:ci] << Locations[:the_cup]
    d.save
    Devices[:iphone].locations.length.should == 2
    Locations[:ci].devices.length.should == 1
  end  
  
  
end