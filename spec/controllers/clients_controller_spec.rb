require 'spec_helper'

describe ClientsController, type: :controller do
  describe "POST create" do
    context "with valid params" do
      before(:each) do
        admin = CreateAdmin.new
        @user = admin.create_user
        controller.stub(:current_user).and_return(@user)
      end
      def params(params = {})
        params[:name] ||= "Appleby Inc."
        params
      end
      it "it should create a client" do
        puts params
        expect{ post :create, :format => 'json', :client => params}.to change{ @user.company.clients.count }.by(1)
      end
    end
  end
end