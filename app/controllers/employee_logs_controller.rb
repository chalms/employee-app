class EmployeeLogsController < ApplicationController
  include ActionController::MimeResponds
  def update
    @user = current_user
    raise Exceptions::StdError, "Unauthorized" if (@user.role.downcase != admin)
    puts "params => #{params.inspect}"
    employee_log = EmployeeLog.find_by_email(params[:id])
    params = params[:employee_log] || params
    if (employee_log)
      @user = User.find_by_email(employee_log.email)
      @user ||= User.find_by_employee_number(employee_log.employee_number)
      @employee_log = employee_log.update_attributes!(params)
      unless (!!@user)
        @user = User.create!(employee_log)
      end
      @user.update_attributes!(params)
      return head :no_content
    end
  rescue Exceptions::StdError => e
    head 500
  end

  def delete_employee
    @user = current_user
    raise Exceptions::StdError, "Unauthorized" if (@user.type.downcase != 'admin')
    puts "params => #{params.inspect}"
    employee_log = EmployeeLog.find_by_email(params[:email])
    user = User.find_by_email(employee_log.email)
    user ||= User.find_by_employee_number(employee_log.employee_number)
    employee_log.destroy
    user.destroy_me!
    return head :no_content
  rescue Exceptions::StdError => e
    puts e.to_s
    head 500
  end

  def destroy
    @user = current_user
    raise Exceptions::StdError, "Unauthorized" if (@user.role.downcase != 'admin')
    puts "params => #{params.inspect}"
    employee_log = EmployeeLog.find_by_email(params[:email])
    user = User.find_by_email(employee_log.email)
    user ||= User.find_by_employee_number(employee_log.employee_number)
    employee_log.destroy
    user.destroy_me!
    return head :no_content
  rescue Exceptions::StdError => e
    head 500
  end
end