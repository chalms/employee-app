require 'spec_helper'

describe EmployeeLogsController, type: :controller do
  describe "POST create" do
    before(:each) do
      admin = CreateAdmin.new
      @user = admin.create_user
      controller.stub(:current_user).and_return(@user)
    end

    describe "with valid params" do
      def params
        params = {
          "name" => "John Watkins",
          "role" => "manager",
          "employee_number" => "4376",
          "company_id" => @user.company.id
        }
        return params
      end

      it "should create a new employee log" do
        expect{ post :create, format: :json, :employee_logs => params }.to change{ @user.company.employee_logs.count }.by(1)
      end

      it "should respond with json" do
        post :create, format: :json, :employee_logs => params
        j =  JSON.parse(response.body)
        j.delete("id")
        j.should == params
      end
    end
  end
end