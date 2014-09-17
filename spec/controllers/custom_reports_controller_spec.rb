require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe CustomReportsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # CustomReport. As you add validations to CustomReport, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CustomReportsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all custom_reports as @custom_reports" do
      custom_report = CustomReport.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:custom_reports)).to eq([custom_report])
    end
  end

  describe "GET show" do
    it "assigns the requested custom_report as @custom_report" do
      custom_report = CustomReport.create! valid_attributes
      get :show, {:id => custom_report.to_param}, valid_session
      expect(assigns(:custom_report)).to eq(custom_report)
    end
  end

  describe "GET new" do
    it "assigns a new custom_report as @custom_report" do
      get :new, {}, valid_session
      expect(assigns(:custom_report)).to be_a_new(CustomReport)
    end
  end

  describe "GET edit" do
    it "assigns the requested custom_report as @custom_report" do
      custom_report = CustomReport.create! valid_attributes
      get :edit, {:id => custom_report.to_param}, valid_session
      expect(assigns(:custom_report)).to eq(custom_report)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new CustomReport" do
        expect {
          post :create, {:custom_report => valid_attributes}, valid_session
        }.to change(CustomReport, :count).by(1)
      end

      it "assigns a newly created custom_report as @custom_report" do
        post :create, {:custom_report => valid_attributes}, valid_session
        expect(assigns(:custom_report)).to be_a(CustomReport)
        expect(assigns(:custom_report)).to be_persisted
      end

      it "redirects to the created custom_report" do
        post :create, {:custom_report => valid_attributes}, valid_session
        expect(response).to redirect_to(CustomReport.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved custom_report as @custom_report" do
        post :create, {:custom_report => invalid_attributes}, valid_session
        expect(assigns(:custom_report)).to be_a_new(CustomReport)
      end

      it "re-renders the 'new' template" do
        post :create, {:custom_report => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested custom_report" do
        custom_report = CustomReport.create! valid_attributes
        put :update, {:id => custom_report.to_param, :custom_report => new_attributes}, valid_session
        custom_report.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested custom_report as @custom_report" do
        custom_report = CustomReport.create! valid_attributes
        put :update, {:id => custom_report.to_param, :custom_report => valid_attributes}, valid_session
        expect(assigns(:custom_report)).to eq(custom_report)
      end

      it "redirects to the custom_report" do
        custom_report = CustomReport.create! valid_attributes
        put :update, {:id => custom_report.to_param, :custom_report => valid_attributes}, valid_session
        expect(response).to redirect_to(custom_report)
      end
    end

    describe "with invalid params" do
      it "assigns the custom_report as @custom_report" do
        custom_report = CustomReport.create! valid_attributes
        put :update, {:id => custom_report.to_param, :custom_report => invalid_attributes}, valid_session
        expect(assigns(:custom_report)).to eq(custom_report)
      end

      it "re-renders the 'edit' template" do
        custom_report = CustomReport.create! valid_attributes
        put :update, {:id => custom_report.to_param, :custom_report => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested custom_report" do
      custom_report = CustomReport.create! valid_attributes
      expect {
        delete :destroy, {:id => custom_report.to_param}, valid_session
      }.to change(CustomReport, :count).by(-1)
    end

    it "redirects to the custom_reports list" do
      custom_report = CustomReport.create! valid_attributes
      delete :destroy, {:id => custom_report.to_param}, valid_session
      expect(response).to redirect_to(custom_reports_url)
    end
  end

end