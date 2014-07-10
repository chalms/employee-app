class EmployeeLogsController < ApplicationController

  include ActionController::MimeResponds

  def index
    @user = current_user
    @employee_logs = @user.company.employee_logs
    respond_to do |format|
      format.json { render json: @employee_logs};
      format.html { render @employee_logs};
    end
  rescue Exceptions::StdError => e
    head 500, :content_type => 'text/html'
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    @user = current_user
    @employee_log = EmployeeLog.find(params[:id])
    validate_employee!
    respond_to do |format|
      format.json { render json: @employee_logs, status: :created };
      format.html { render @employee_logs };
    end
rescue Exceptions::StdError => e
    head 500, :content_type => 'text/html'
  end
  # POST /contacts
  # POST /contacts.json
  def create
    @user = current_user
    @employee_log = EmployeeLog.create!(params[:employee_logs])
    respond_to do |format|
      format.json { render json: @employee_log };
      format.html { render @employee_log};
    end
rescue Exceptions::StdError => e
    head 500, :content_type => 'text/html'
  end
  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    @user = current_user
    @employee_log = EmployeeLog.find(params[:id])
    params.delete!(:id)
    @employee_log.update_attributes!(params)
    respond_to do |format|
      format.json { render json: @employee_log };
      format.html { render @employee_log};
    end
rescue Exceptions::StdError => e
    head 500, :content_type => 'text/html'
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    head 200, :content_type => 'text/html'
rescue Exceptions::StdError => e
    head 500, :content_type => 'text/html'
  end

  private

  def clean_update!
    return {
      :role => params[:employee_log][:role],
      :name => params[:employee_log][:name],
      :company_id => @user.company.id
    }
  end

  def validate_employee!
    raise Exceptions::StdError, "You cannot access this record!" unless (@employee_log && (@user.role == 'companyAdmin'))
  end
end