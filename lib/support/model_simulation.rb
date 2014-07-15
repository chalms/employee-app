class ModelSimulation

  def initialize
    f_report = FakeReport.new
    @tasks = FakeTasks.new(f_report).fake_tasks
    @parts = FakeParts.new(f_report).fake_parts
    @employees = FakeEmployees.new(f_report.fake_manager.company).fake_employees
    @report = f_report.fake_report
    @user_reports = []
    @employees.each do |employee|
      @user_reports << employee.users_reports.create!({:report_id => @report.id})
    end
    FakeReportsTasks.new(@tasks, @user_reports)
    @reports_tasks = []
    @user_reports.each do |u_r|
      @reports_tasks << u_r.tasks
    end
    puts "starting fake reprots parts"
    FakeReportsParts.new(@parts, @user_reports)
    puts "done fake reports parts"
    @reports_parts = []
    @user_reports.each do |u_r|
      @reports_parts << u_r.parts
    end
    @user_reports.each do |u_r|
      u_r.chat.send_message("Hello!", nil, u_r.user.id )
    end

    # f_chat = FakeChats.new([@report])
    # @chats = f_chat.fake_chats
    # @conversation = f_chat.fake_conversation
  end

  def print
    puts report.inspect
    puts tasks.inspect
    puts employees.inspect
    puts user_reports.inspect
    puts employees.inspect
    puts reports_tasks.inspect
    puts reports_parts.inspect
    # puts chats.inspect
    # puts conversation.inspect
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

  # def chats
  #   @chats
  # end

  # def conversation
  #   @conversation
  # end
end
