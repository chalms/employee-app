require 'spec_helper'

describe CompanyAdminController, type: :controller do
  describe "POST authentication" do
    let(:user_params) {{
        :email => "a@chalme.com", 
        :password => "password"
    }}
    let(:bad_user_params) {{
        :email => "a@chalme.com", 
        :password => "passord"
    }}
    let(:params) {{
        :email => "a@chalme.com", 
        :password => "password", 
        :employee_number => "300"
    }}
    let(:employee_log) {{
        :name => "Andrew Chalmers", 
        :role => "companyAdmin", 
        :employee_number => "300"
    }}

    def go!
      company = Company.create!({:name => "AC cooling systems"})
      company.employee_logs.create!(employee_log)
      company.users.create!(params)   
    end 

    before(:each) do 
      go!
    end 

    it "should render admin_onboarding template" do
      post :authentication, user_params
      expect(response).to render_template("admin_onboarding")
    end

    it "should not render bad user params" do
      post :authentication, bad_user_params
      expect(response).to render_template("admin_home")
    end 

    # it "renders the index template" do
    #   get :index
    #   expect(response).to render_template("index")
    # end
  end
end
