require 'rails_helper'

RSpec.describe "ReportTasks", :type => :request do
  describe "GET /report_tasks" do
    it "works! (now write some real specs)" do
      get report_tasks_path
      expect(response.status).to be(200)
    end
  end
end
