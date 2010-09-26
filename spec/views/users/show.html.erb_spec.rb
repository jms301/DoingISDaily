require 'spec_helper'

describe "/users/show.html.erb" do
  include UsersHelper
  before(:each) do
    assigns[:user] = @user = stub_model(User,
      :username => "value for username"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ username/)
  end
end
