require 'spec_helper'

describe PastAction do
  before(:each) do
    @valid_attributes = { :description=>'Went to the shops', 
                          :started_at=>(Time.now-10.minutes), 
                          :ended_at=>Time.now} 
  end

  it "should create a new instance given valid attributes" do
    user = User.create({:username=>"name"})
    user.past_actions.create!(@valid_attributes)
  end

#  it "should be owned by a user" do 
#
#  end
#
#  it "should always have a start time and description"  do
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
