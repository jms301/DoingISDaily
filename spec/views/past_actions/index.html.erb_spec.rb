require 'spec_helper'

describe "/past_actions/index.html.erb" do
  include PastActionsHelper

  before(:each) do
    assigns[:past_actions] = [
      stub_model(PastAction),
      stub_model(PastAction)
    ]
  end

  it "renders a list of past_actions" do
    render
  end
end
