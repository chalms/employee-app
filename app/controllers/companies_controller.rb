class CompaniesController < ApplicationController

  def show
    @company = Company.find(params[:id])
    respond_to do |format|
      format.json{ render json: @company.to_json }
    end
  end

  def index
    @companies = Company.all.map { |c| {:name => c.name, :id => c.id} }
    @companies = @companies.to_json
    respond_to do |format|
      format.json { render json: @companies }
    end
  end
end