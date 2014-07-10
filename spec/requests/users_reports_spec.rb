require 'rails_helper'

RSpec.describe "UsersReports", :type => :request do
  describe "GET /users_reports" do
    it "works! (now write some real specs)" do
      get users_reports_path
      expect(response.status).to be(200)
    end
  end
end
