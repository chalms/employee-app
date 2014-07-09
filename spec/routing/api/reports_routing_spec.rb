require 'spec_helper'

describe Api::ReportsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/api/reports").to route_to("api/reports#index")
    end

    it "routes to #new" do
      expect(:get => "/api/reports/new").to route_to("api/reports#new")
    end

    it "routes to #show" do
      expect(:get => "/api/reports/1").to route_to("api/reports#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/api/reports/1/edit").to route_to("api/reports#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/api/reports").to route_to("api/reports#create")
    end

    it "routes to #update" do
      expect(:put => "/api/reports/1").to route_to("api/reports#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/reports/1").to route_to("api/reports#destroy", :id => "1")
    end

  end
end
