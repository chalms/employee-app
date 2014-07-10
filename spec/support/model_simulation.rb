class ModelSimulation

  def initialize
    f_report = FakeReport.new
    @tasks = FakeTasks.new(f_report).fake_tasks
    @parts = FakeParts.new(f_report).fake_parts
    @employees = FakeEmployees.new(f_report.fake_manager.company).fake_employees
    @report = f_report.report
    @user_reports = []
    @employees.each do |employee|
      @user_reports << employee.user_reports.create!({:report_id => @report.id})
    end
    FakeReportsTasks.new(@tasks, @user_reports)
    @reports_tasks = @user_reports.tasks
    FakeReportsParts.new(@parts, @user_reports)
    @reports_parts = @user_reports.parts

    f_chat = FakeChats.new(@user_reports)
    @chats = f_chat.fake_chats
    @conversation = f_chat.fake_conversions
  end

  def print
    puts report.inspect
    puts tasks.inspect
    puts employees.inspect
    puts user_reports.inspect
    puts employees.inspect
    puts reports_tasks.inspect
    puts reports_parts.inspect
    puts chats.inspect
    puts conversation.inspect
  end


  def report
    @report
  end

  def tasks
    @tasks
  end

  def employees
    @employees
  end

  def user_reports
    @user_reports
  end

  def employees
    @employees
  end

  def reports_tasks
    @reports_tasks
  end

  def reports_parts
    @reports_parts
  end

  def chats
    @chats
  end

  def conversation
    @conversation
  end
end
