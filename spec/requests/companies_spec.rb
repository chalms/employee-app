require 'spec_helper'

describe "Companies", :type => :request do
  describe "GET /companies" do
    it "works! (now write some real specs)" do
      get companies_path
      expect(response.status).to be(200)
    end
  end
end
