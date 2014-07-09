require 'spec_helper'

describe "ReportsParts", :type => :request do
  describe "GET /reports_parts" do
    it "works! (now write some real specs)" do
      get reports_parts_path
      expect(response.status).to be(200)
    end
  end
end
