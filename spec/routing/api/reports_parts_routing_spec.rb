require 'spec_helper'

describe Api::ReportsPartsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/reports_parts").to route_to("reports_parts#index")
    end

    it "routes to #new" do
      expect(:get => "/reports_parts/new").to route_to("reports_parts#new")
    end

    it "routes to #show" do
      expect(:get => "/reports_parts/1").to route_to("reports_parts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/reports_parts/1/edit").to route_to("reports_parts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/reports_parts").to route_to("reports_parts#create")
    end

    it "routes to #update" do
      expect(:put => "/reports_parts/1").to route_to("reports_parts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/reports_parts/1").to route_to("reports_parts#destroy", :id => "1")
    end

  end
end
