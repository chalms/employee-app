require "rails_helper"

RSpec.describe ReportPartsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/report_parts").to route_to("report_parts#index")
    end

    it "routes to #new" do
      expect(:get => "/report_parts/new").to route_to("report_parts#new")
    end

    it "routes to #show" do
      expect(:get => "/report_parts/1").to route_to("report_parts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/report_parts/1/edit").to route_to("report_parts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/report_parts").to route_to("report_parts#create")
    end

    it "routes to #update" do
      expect(:put => "/report_parts/1").to route_to("report_parts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/report_parts/1").to route_to("report_parts#destroy", :id => "1")
    end

  end
end
