require "rails_helper"

RSpec.describe UsersReportsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/users_reports").to route_to("users_reports#index")
    end

    it "routes to #new" do
      expect(:get => "/users_reports/new").to route_to("users_reports#new")
    end

    it "routes to #show" do
      expect(:get => "/users_reports/1").to route_to("users_reports#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/users_reports/1/edit").to route_to("users_reports#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/users_reports").to route_to("users_reports#create")
    end

    it "routes to #update" do
      expect(:put => "/users_reports/1").to route_to("users_reports#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/users_reports/1").to route_to("users_reports#destroy", :id => "1")
    end

  end
end
