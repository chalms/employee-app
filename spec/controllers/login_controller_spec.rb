require 'spec_helper'

describe LoginController, type: :controller do
  describe "POST valid_login" do
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

    it "should render admin template" do
      post :valid_login, user_params
      expect(response).to render_template("admin")
    end

    it "should render login template" do
      post :valid_login, bad_user_params
      expect(response).to render_template("login")
    end

    # it "renders the index template" do
    #   get :index
    #   expect(response).to render_template("index")
    # end
  end
  describe "POST valid_signup" do
    let(:user_params) {{
        :email => "a@chalme.com",
        :password => "password",
        :employee_number => "300"
    }}
    let(:bad_user_params) {{
        :email => "a@chalme.com",
        :password => "passord"
    }}
    let(:params) {}
    let(:employee_log) {{
        :name => "Andrew Chalmers",
        :role => "companyAdmin",
        :employee_number => "400"
    }}

    def params
      params = {
        :email => "a@chalme.com",
        :password => "password",
        :employee_number => "400",
        :name => "Andrew",
        :company_id => @company.id
      }
      return params
    end

    def bad_params
      params = {
        :email => "a@chalme.com",
        :password => "password",
        :employee_number => "500",
        :name => "Andrew",
        :company_id => @company.id
      }
      return params
    end


    def go!
      @company = Company.create!({:name => "AC cooling systems"})
      @company.employee_logs.create!(employee_log)
    end

    before(:each) do
      go!
    end

    it "should render admin template" do
      post :valid_signup, params
      expect(response).to render_template("admin")
    end

    it "should not render sign_up template" do
      post :valid_signup, bad_params
      expect(response).to render_template("sign_up")
    end

    # it "renders the index template" do
    #   get :index
    #   expect(response).to render_template("index")
    # end
  end
end
