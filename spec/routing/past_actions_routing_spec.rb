require 'spec_helper'

describe PastActionsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/past_actions" }.should route_to(:controller => "past_actions", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/past_actions/new" }.should route_to(:controller => "past_actions", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/past_actions/1" }.should route_to(:controller => "past_actions", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/past_actions/1/edit" }.should route_to(:controller => "past_actions", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/past_actions" }.should route_to(:controller => "past_actions", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/past_actions/1" }.should route_to(:controller => "past_actions", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/past_actions/1" }.should route_to(:controller => "past_actions", :action => "destroy", :id => "1") 
    end
  end
end
