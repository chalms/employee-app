require 'rails_helper'

RSpec.describe "CustomReports", :type => :request do
  describe "GET /custom_reports" do
    it "works! (now write some real specs)" do
      get custom_reports_path
      expect(response.status).to be(200)
    end
  end
end
