class EmployeesController < ApplicationController
  include ActionController::MimeResponds

  before_action :user!, except: [:upload]

  def index
    manager_or_admin!
    puts params
    @data = params[:data]
    @div = @data.delete(:div)
    type = @data[:options].delete(:type)


    if @data[:options][:project_id].present?
      if type != 'Employee'
        q1 = User.joins(:reports).where(reports: @data[:options], user: { type: ('Manager' || 'Admin')} ).uniq!
        puts q1.inspect
        @data[:employees] = q1

      else
        q2 = User.joins(users_reports: [:user, :report]).where(reports: @data[:options], users: { type: 'Employee'} ).uniq!
        puts q2.inspect
        @data[:employees] = q2
      end
    end
    @data[:type] = @data[:options].delete(:type)
    @data[:employee_logs] = @user.company.employee_logs
    puts @user.company.employee_logs

    puts "PAST THE QUERY"
    respond_to do |format|
      format.json { render json: @data }
      format.js
    end
  end

  def days_timesheet
    @data = params[:data]
    @div = @data.delete(:div)
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
    @user = current_user
    manager_or_admin!
    @data = params[:data] || params
    @data[:employee] = @user.company.employees.find(params[:id].to_i)
    @data[:options] ||= {}
    @div = @data.delete(:div)
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
    @user = current_user(params[:user_auth])
    is_admin!
    puts "params: => #{params}"
    file_data = params[:file]
    puts "file_data: => #{file_data}"
    @employee_logs = EmployeeCsv.new(file_data, @user).employee_logs
    puts "employee logs: #{@employee_logs}"
    @employee_logs.each do |log|
      render 'employees/log_row', :locals => {:log => log}, :formats => [:js]
    end
    return head :ok
  end

  def upload_form

    is_admin!
    respond_to do |format|
      format.js
    end
  end

  def save_data
    @user = current_user
    is_admin!
    puts params.inspect
    @employee_logs = params[:employee_logs]
    @employee_logs.each do |k,v|
      puts v
      v.each_with_index do |c,i|
        puts "c: #{c}, i: #{i}"
        @employee_logs.each do |x,y|
          puts "y[i] : #{y[i]}"
          puts c.blank?
          y.delete_at(i) if c.blank?
        end
      end
    end
    @employee_logs[:employee_number].each_with_index do |log, i|
      hash = { :email => @employee_logs[:email][i], :employee_number => log, :role => @employee_logs[:role][i], :company_id => @user.company.id }
      emp_num = hash[:employee_number].gsub('/\s+/', "")
      employee = EmployeeLog.find_by_employee_number(emp_num)
      employee ||= EmployeeLog.find_by_email(hash[:email].gsub('/\s+/',""))
      if (employee)
        user = User.find_by_email(employee.email)
        user ||= User.find_by_employee_number(employee.employee_number)
        employee.update_attributes!(hash)
        unless (!!user)
          User.create!(hash)
        end
        employee = nil
        user = nil
      else
        EmployeeLog.create!(hash)
        User.create!(hash)
      end
    end
    puts 131
    @employee_logs = @user.company.employee_logs
    render :nothing => true
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

  def is_admin!
    raise Exceptions::StdError, "user is not admin. role: #{@user.role}" if (@user.role.downcase != 'admin' && @user.role.downcase != 'companyadmin')
  end

  def manager_or_admin!
    raise Exceptions::StdError, "User is an employee" if (@user.role.downcase == 'employee')
  end

  def user!
    @user = current_user
  end
end