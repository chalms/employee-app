require 'rails_helper'

RSpec.describe "ReportsTasks", :type => :request do
  describe "GET /reports_tasks" do
    it "works! (now write some real specs)" do
      get reports_tasks_path
      expect(response.status).to be(200)
    end
  end
end
