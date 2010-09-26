require 'spec_helper'

describe "/past_actions/edit.html.erb" do
  include PastActionsHelper

  before(:each) do
    assigns[:past_action] = @past_action = stub_model(PastAction,
      :new_record? => false
    )
  end

  it "renders the edit past_action form" do
    render

    response.should have_tag("form[action=#{past_action_path(@past_action)}][method=post]") do
    end
  end
end
