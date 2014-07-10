require 'spec_helper'

describe ProjectsController, type: :controller do
  describe "POST create" do
    context 'with valid params' do

      before(:each) do
        admin = CreateAdmin.new
        @user = admin.create_user
        controller.stub(:current_user).and_return(@user)
        @client = CreateClient.new(@user).client
      end

      let(:project_hash) {{
          "assigned_parts"=>[],
          "assigned_tasks"=>[],
          "completed_parts"=>[],
          "completed_tasks"=>[],
          "hours"=>0,
          "employee_days_worked"=>0,
          "employees"=>[],
          "managers"=>[],
          "reports"=>[],
          "parts"=>[],
          "tasks"=>[],
          "contacts"=>[],
          "clients"=>[]
      }}

      def params(params = {})
        params["company_id"] ||= @user.company.id
        params["start_date"] ||= (Date.today)
        params["end_date"]   ||= (Date.today + 100)
        params["manager_number"] ||= @user.id
        params["budget"]     ||= 300000
        params["clients"] = [@client.id]
        params["complete"] = false
        params["name"]  = "Project X"
        params
      end

      it "should be created successfully" do
        expect{ post :create, :format => 'json', :project => params}.to change{ @user.company.projects.count }.by(1)
      end

      it "should return project" do
        post :create, :format => 'json', :project => params
        expect(project_hash.merge(params)).to eq(JSON.parse(response.body))
      end
    end
  end

  describe "PUT update" do

    context 'with valid params' do
      before(:each) do
        admin = CreateAdmin.new
        @user = admin.create_user
        controller.stub(:current_user).and_return(@user)
        @client = CreateClient.new(@user).client
        @project = @user.company.projects.create!({
          "company_id" => @user.company.id,
          "start_date" => Date.today,
          "end_date" => (Date.today + 100),
          "manager_number" => @user.id,
          "budget" => 300000,
          "name" => "Project X",
          "complete" => false
        })
      end

      let(:project_hash) {{
          "assigned_parts"=>[],
          "assigned_tasks"=>[],
          "completed_parts"=>[],
          "completed_tasks"=>[],
          "hours"=>0,
          "employee_days_worked"=>0,
          "employees"=>[],
          "managers"=>[],
          "reports"=>[],
          "parts"=>[],
          "tasks"=>[],
          "contacts"=>[],
          "clients"=>[]
      }}

      def params
        params = {
          "company_id" => @user.company.id,
          "start_date" => Date.today,
          "end_date" => (Date.today + 100),
          "manager_number" => @user.id,
          "budget" => 200000,
          "name" => "Project X",
          "complete" => false
        }
        params
      end

      def json_parse(response)
        j = JSON.parse(response.body)
        new_project["budget"] = 200000.0
        new_project["start_date"] = new_project["start_date"].to_s
        new_project["end_date"] = new_project["end_date"].to_s
        j
      end

      it "should update project name" do
        put :update, {:id => @project.id, :project => params}, :format => :json
        budget = Project.find(@project.id).budget
        expect(budget).to be(200000.0)
      end

      it "should return json" do
        put :update, {:id => @project.id, :project => params, :format => :json}
        expect(project_hash.merge(params)).to eq(JSON.parse(response.body))
      end
    end
  end
end

