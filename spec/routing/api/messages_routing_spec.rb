require "rails_helper"

RSpec.describe Api::MessagesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/api/messages").to route_to("api/messages#index")
    end

    it "routes to #new" do
      expect(:get => "/api/messages/new").to route_to("api/messages#new")
    end

    it "routes to #show" do
      expect(:get => "/api/messages/1").to route_to("api/messages#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/api/messages/1/edit").to route_to("api/messages#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/api/messages").to route_to("api/messages#create")
    end

    it "routes to #update" do
      expect(:put => "/api/messages/1").to route_to("api/messages#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/messages/1").to route_to("api/messages#destroy", :id => "1")
    end

  end
end
