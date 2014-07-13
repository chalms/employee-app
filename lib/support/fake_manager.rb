class FakeManager
  def initialize
    f_client = FakeClient.new
    puts "fake client"
    @admin = f_client.fake_admin
    @client = f_client.fake_client
    @admin.company.employee_logs.create!({
      :name => "Andrew Chalmers",
      :role => 'manager',
      :employee_number => '250569554'
    })
    @manager = @admin.company.users.create!({
      :name => "Andrew Chalmers",
      :employee_number => '250569554',
      :email => "andrew.chalmers@gmail.com",
      :password => "password"
    })
  end

  def fake_client
    @client
  end

  def fake_admin
    @admin
  end

  def fake_manager
    @manager
  end

end