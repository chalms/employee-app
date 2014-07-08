require 'rails_helper'

RSpec.describe "ReportParts", :type => :request do
  describe "GET /report_parts" do
    it "works! (now write some real specs)" do
      get report_parts_path
      expect(response.status).to be(200)
    end
  end
end
