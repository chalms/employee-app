require "rails_helper"

RSpec.describe ReportTasksController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/report_tasks").to route_to("report_tasks#index")
    end

    it "routes to #new" do
      expect(:get => "/report_tasks/new").to route_to("report_tasks#new")
    end

    it "routes to #show" do
      expect(:get => "/report_tasks/1").to route_to("report_tasks#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/report_tasks/1/edit").to route_to("report_tasks#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/report_tasks").to route_to("report_tasks#create")
    end

    it "routes to #update" do
      expect(:put => "/report_tasks/1").to route_to("report_tasks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/report_tasks/1").to route_to("report_tasks#destroy", :id => "1")
    end

  end
end
