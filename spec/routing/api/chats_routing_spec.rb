require 'spec_helper'

describe Api::ChatsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/api/chats").to route_to("api/chats#index")
    end

    it "routes to #new" do
      expect(:get => "/api/chats/new").to route_to("api/chats#new")
    end

    it "routes to #show" do
      expect(:get => "/api/chats/1").to route_to("api/chats#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/api/chats/1/edit").to route_to("api/chats#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/api/chats").to route_to("api/chats#create")
    end

    it "routes to #update" do
      expect(:put => "/api/chats/1").to route_to("api/chats#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/chats/1").to route_to("api/chats#destroy", :id => "1")
    end

  end
end
