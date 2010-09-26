require 'spec_helper'

describe PastActionsController do

  def mock_past_action(stubs={})
    @mock_past_action ||= mock_model(PastAction, stubs)
  end

  describe "GET index" do
    it "assigns all past_actions as @past_actions" do
      PastAction.stub(:find).with(:all).and_return([mock_past_action])
      get :index
      assigns[:past_actions].should == [mock_past_action]
    end
  end

  describe "GET show" do
    it "assigns the requested past_action as @past_action" do
      PastAction.stub(:find).with("37").and_return(mock_past_action)
      get :show, :id => "37"
      assigns[:past_action].should equal(mock_past_action)
    end
  end

  describe "GET new" do
    it "assigns a new past_action as @past_action" do
      PastAction.stub(:new).and_return(mock_past_action)
      get :new
      assigns[:past_action].should equal(mock_past_action)
    end
  end

  describe "GET edit" do
    it "assigns the requested past_action as @past_action" do
      PastAction.stub(:find).with("37").and_return(mock_past_action)
      get :edit, :id => "37"
      assigns[:past_action].should equal(mock_past_action)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created past_action as @past_action" do
        PastAction.stub(:new).with({'these' => 'params'}).and_return(mock_past_action(:save => true))
        post :create, :past_action => {:these => 'params'}
        assigns[:past_action].should equal(mock_past_action)
      end

      it "redirects to the created past_action" do
        PastAction.stub(:new).and_return(mock_past_action(:save => true))
        post :create, :past_action => {}
        response.should redirect_to(past_action_url(mock_past_action))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved past_action as @past_action" do
        PastAction.stub(:new).with({'these' => 'params'}).and_return(mock_past_action(:save => false))
        post :create, :past_action => {:these => 'params'}
        assigns[:past_action].should equal(mock_past_action)
      end

      it "re-renders the 'new' template" do
        PastAction.stub(:new).and_return(mock_past_action(:save => false))
        post :create, :past_action => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested past_action" do
        PastAction.should_receive(:find).with("37").and_return(mock_past_action)
        mock_past_action.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :past_action => {:these => 'params'}
      end

      it "assigns the requested past_action as @past_action" do
        PastAction.stub(:find).and_return(mock_past_action(:update_attributes => true))
        put :update, :id => "1"
        assigns[:past_action].should equal(mock_past_action)
      end

      it "redirects to the past_action" do
        PastAction.stub(:find).and_return(mock_past_action(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(past_action_url(mock_past_action))
      end
    end

    describe "with invalid params" do
      it "updates the requested past_action" do
        PastAction.should_receive(:find).with("37").and_return(mock_past_action)
        mock_past_action.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :past_action => {:these => 'params'}
      end

      it "assigns the past_action as @past_action" do
        PastAction.stub(:find).and_return(mock_past_action(:update_attributes => false))
        put :update, :id => "1"
        assigns[:past_action].should equal(mock_past_action)
      end

      it "re-renders the 'edit' template" do
        PastAction.stub(:find).and_return(mock_past_action(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested past_action" do
      PastAction.should_receive(:find).with("37").and_return(mock_past_action)
      mock_past_action.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the past_actions list" do
      PastAction.stub(:find).and_return(mock_past_action(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(past_actions_url)
    end
  end

end
