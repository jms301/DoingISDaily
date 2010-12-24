require 'spec_helper'

describe Event do
  before(:each) do
    @valid_attributes = { :description=>'Went to the shops', 
                          :start_time=>(Time.now-10.minutes), 
                          :end_time=>Time.now} 
  end

  it "should create a new instance given valid attributes" do
    user = User.create({:username=>"name"})
    user.events.create!(@valid_attributes)
  end

#  it "should be owned by a user" do 
#
#  end
#
#  it "should always have a description"  do
#    
#  end
#
#  it "should store what the action is." do
#  end 
#
#  it "should relate to arbitrary categories." do
#  end 
#
#  it "should store a start time" do
#  end 
#
end
