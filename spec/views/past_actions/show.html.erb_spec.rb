require 'spec_helper'

describe "/past_actions/show.html.erb" do
  include PastActionsHelper
  before(:each) do
    assigns[:past_action] = @past_action = stub_model(PastAction)
  end

  it "renders attributes in <p>" do
    render
  end
end
