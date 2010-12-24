require 'spec_helper'

describe Plan do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :parent_id => 1,
      :user_id => 1,
      :deadline => 
    }
  end

  it "should create a new instance given valid attributes" do
    Plan.create!(@valid_attributes)
  end
end
