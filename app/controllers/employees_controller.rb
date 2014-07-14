class EmployeesController < ApplicationController
  include ActionController::MimeResponds

  before_action :user!

  def index
    manager_or_admin!
    @company = @user.company
    @employee_logs = @user.company.employee_logs
    respond_to do |format|
      format.js
    end
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

  def show
    respond_to do |format|
      format.json { render json: @user }
      format.js
    end
  end

  def new
    is_admin!
    @employee_logs = @user.company.employee_logs
    respond_to do |format|
      format.js
    end
  end

  def upload
    is_admin!
    file_data = params[:upload]
    @employee_logs = EmployeeCsv.new(file_data).employee_logs
    @employee_logs.each do |log|
      render 'employees/log_row', :locals => {:log => log}
    end
rescue Exceptions::StdError => e
    flash[:error] = e
  end

  def save_data
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
  rescue Exceptions::StdError => e
    @error_message = "Logs could not be saved due to error: #{e.message}"
    flash[:error] = @error_message
    render :text => @error_message
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    head :no_content
  end

  private

  def manager_or_admin!
    raise Exceptions::StdError, "User is an employee" if (@user.role.downcase != 'employee')
  end

  def user!
    @user = current_user
  end
end