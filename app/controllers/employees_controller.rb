class EmployeesController < ApplicationController
  include ActionController::MimeResponds

  before_action :user!

  def index
    is_manager!
    @users =
    render json: @users
  end

  def days_timesheet
    @data = params[:data]
    respond_to do |format|
      format.json { render json: @data }
      format.js
    end
  end

  def hours_timesheet
    @data = params[:data]
    respond_to do |format|
      format.json { render json: @data }
      format.js
    end
  end
  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    render json: @user
  end

  def new

  end

  def upload
    @user = current_user
    is_admin!
    file_data = params[:upload]

    @employee_logs = EmployeeCsv.new(file_data).employee_logs
    @employee_logs.each do |log|
      render 'employees/log_row', :locals => {:log => log}
    end
rescue Exceptions::StdError => e
    flash[:error] = e
  end

  def save_logs
    @user = current_user
    is_admin!

    @employee_logs = params[:employee_logs]
    puts @employee_logs.inspect!
    @employee_logs[:employee_number].each_with_index do |log, i|
      hash = { :email => @employee_logs[:email][i], :employee_number => log, :role => @employee_logs[:role][i] }
      employee = EmployeeLog.find_by_employee_number(hash[:employee_number])
      employee ||= EmployeeLog.find_by_email(hash[:email])
      if (employee)
        user = User.find_by_email(employee.email)
        user ||= User.find_by_employee_number(employee.employee_number)
      end
      employee.update_attributes!(hash) if (!!employee)
      user.update_attributes!(hash) if (!!user)
    end
    @employee_logs = @user.company.employee_logs
    respond_to do |format|
      format.js
    end
  rescue Exceptions::StdError => e,
    @error_message = "Logs could not be saved due to error: #{e.message}"
    flash[:error] = @error_message
    render :text => @error_message
  end

  def update
    is_manager!
    @employee = User.find(params[:id])

    if @user.update(params[:user])
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    head :no_content
  end

  def user!
    @user = current_user
  end
end