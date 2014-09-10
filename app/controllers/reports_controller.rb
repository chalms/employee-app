class ReportsController < ApplicationController

  include ActionController::MimeResponds

  def index
    @user = current_user
    puts "#{@user.inspect}"
    validate_user_role!
    @data = params[:data]
    @data[:reports] = Report.where(params[:options]).order(:date)
    @div = params[:data][:div]
    if (!!@data)
      respond_to do |format|
        puts format.inspect
        format.json { render json: @data, status: :success }
        format.js
      end
    else
      @reports = @user.reports
      respond_to do |format|
        format.json { render json: @reports, status: :success }
        format.js
      end
    end
  end

  def today
    @user = current_user
    if @user.role.downcase == 'employee'
      @reports = @user.todays_activity
      if @reports
        render json: @reports
      end
    end
  end

  def show
    @user = current_user
    puts params
    @report = Report.find(params[:id])
    @options = params[:options]
    @div = params[:div]
    @data = {}
    @data[:report] = @report
    @data[:options] = @options if (@options)
    @data[:div] = @div if (@div)
    respond_to do |format|
      format.json { render json: @report, status: :success }
      format.js
    end
  end

  def new
    @user = current_user
    validate_user_role!
    @report = build_new_report!(params)
    @data = {}
    @data[:report] = @report
    @data[:users_reports] = @report.users_reports
    @div = params[:div] ||= nil
    @data[:div] = @div if @div
    validate_user_role!
    respond_to do |format|
      format.json { render json: @report, status: :success }
      format.html { render haml: @report }
      format.js
    end
  end

  def create
    @user = current_user
    validate_user_role!
    if (@user.type == 'Admin')
      @user = Admin.find(@user.id)
    elsif (@user.type == 'Manager')
      @user = Manager.find(@user.id)
    end
    @div = params[:div] if (params[:div])
    @report = @user.add_report(params)
    @data = {}
    @data[:report] = @report
    @data[:options] = params[:options] || {}
    @data[:div] = @div
    if @report
      respond_to do |format|
        format.json { render json: @report};
        format.html { render haml: @report }
        format.js
      end
    end
  end

  def table
    @user = current_user
    @data = params[:data]
    respond_to do |format|
      format.json { render json: @data }
      format.js
    end
  end

  def update
    @user = current_user
    @report = Report.find(params[:id])
    if @report.update(params[:report])
      puts "report, update -> #{@report.inspect}"
      puts "report, update, to_json #{@report.to_json}"
      respond_to do |format|
        format.json { render status: 200, json: @report.to_json.to_json }
        format.html {render haml: @report }
        format.js
      end
    else
      respond_to do |format|
        format.json {render status: :unprocessable_entity  }
        format.html {render haml: @report }
        format.js
      end
    end
  rescue Exception => e
    puts "#{e.inspect}"
    puts "#{e.message}"
    head 500
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy_me!
    head :no_content
  rescue Exceptions::StdError => e
    puts "#{e.inspect}"
    head 500
  end

  private

  def build_new_report!(params)

    data = {}
    if params[:options]
      data[:project_id] = params[:options][:project_id] if params[:options][:project_id]
    end
    data[:user_id] = @user.id
    data[:date] = (Date.today + 1)
    data[:name] = "#{@user.name}, #{data[:date].to_s}"
    data[:summary] = "Add a report summary here!"
    return @user.reports.create!(data)
  end
  def validate_user_role!
    if (@user.present?)

      raise Exceptions::StdError, "Invalid permission to access" if (@user.role.downcase == 'employee')
    end
  end

end
