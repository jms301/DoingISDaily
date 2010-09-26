require 'spec_helper'

describe "/past_actions/new.html.erb" do
  include PastActionsHelper

  before(:each) do
    assigns[:past_action] = stub_model(PastAction,
      :new_record? => true
    )
  end

  it "renders new past_action form" do
    render

    response.should have_tag("form[action=?][method=post]", past_actions_path) do
    end
  end
end
