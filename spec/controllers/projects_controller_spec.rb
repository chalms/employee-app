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

      let(:project_hash) {
        { "project" => {
            "name"=>nil,
            "budget"=>300000.0,
            "complete"=>false,
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
            "contacts"=>[]
          }
        }
      }

      def params(params = {})
        params[:company_id] ||= @user.company.id
        params[:start_date] ||= (Date.new)
        params[:end_date]   ||= (Date.new + 100)
        params[:manager_id] ||= @user.id
        params[:budget]     ||= 300000
        params[:client_id]  ||= @client.id
        params
      end

      it "should be created successfully" do
        expect{ post :create, :format => 'json', :project => params}.to change{ @user.company.projects.count }.by(1)
      end

      it "should return project" do
        post :create, :format => 'json', :project => params
        j = JSON.parse(response.body)
        project_hash["project"]["company_id"] = @user.company.id
        project_hash["project"]["start_date"] = params[:start_date].to_s
        project_hash["project"]["end_date"] = params[:end_date].to_s
        j.should == project_hash
      end
    end
  end

  describe "PUT update" do
    let(:new_project) {{
      "company_id" => @user.company.id,
      "start_date" => Date.new,
      "end_date" => (Date.new + 100),
      "manager_id" => @user.id,
      "budget" => 300000,
      "client_id" => @client.id,
      "name" => "Project X",
      "complete" => false
    }}
    context 'with valid params' do
      before(:each) do
        admin = CreateAdmin.new
        @user = admin.create_user
        controller.stub(:current_user).and_return(@user)
        @client = CreateClient.new(@user).client
        @project = @user.company.projects.create!(new_project)
      end

      def params(params = {})
        params[:budget] = 200000
        params
      end

      def json_parse(response)
        j = JSON.parse(response.body)
        j.delete("id")
        j.delete("created_at")
        j.delete("updated_at")
        new_project["budget"] = 200000.0
        j
      end

      it "should update project name" do
        put :update, {:id => @project.id, :project => params}, :format => :json
        budget = Project.find(@project.id).budget
        expect(budget).to be(200000.0)
      end

      it "should return json" do
        put :update, {:id => @project.id, :project => params, :format => :json}
        j = json_parse(response)
        j.should == new_project
      end
    end
  end

  describe "GET show" do
    context "with valid params" do
      before(:each) do
        admin = CreateAdmin.new
        @user = admin.create_user
        controller.stub(:current_user).and_return(@user)
        @client = CreateClient.new(@user).client
        @project = @user.company.projects.create!({
          :company_id => @user.company.id,
          :start_date => Date.new,
          :end_date => (Date.new + 100),
          :manager_id => @user.id,
          :budget => 300000,
          :client_id => @client.id
        })
      end
    end
  end
end

