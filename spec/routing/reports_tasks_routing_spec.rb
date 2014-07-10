require "rails_helper"

RSpec.describe ReportsTasksController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/reports_tasks").to route_to("reports_tasks#index")
    end

    it "routes to #new" do
      expect(:get => "/reports_tasks/new").to route_to("reports_tasks#new")
    end

    it "routes to #show" do
      expect(:get => "/reports_tasks/1").to route_to("reports_tasks#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/reports_tasks/1/edit").to route_to("reports_tasks#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/reports_tasks").to route_to("reports_tasks#create")
    end

    it "routes to #update" do
      expect(:put => "/reports_tasks/1").to route_to("reports_tasks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/reports_tasks/1").to route_to("reports_tasks#destroy", :id => "1")
    end

  end
end
