require "rails_helper"

RSpec.describe CustomReportsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/custom_reports").to route_to("custom_reports#index")
    end

    it "routes to #new" do
      expect(:get => "/custom_reports/new").to route_to("custom_reports#new")
    end

    it "routes to #show" do
      expect(:get => "/custom_reports/1").to route_to("custom_reports#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/custom_reports/1/edit").to route_to("custom_reports#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/custom_reports").to route_to("custom_reports#create")
    end

    it "routes to #update" do
      expect(:put => "/custom_reports/1").to route_to("custom_reports#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/custom_reports/1").to route_to("custom_reports#destroy", :id => "1")
    end

  end
end
