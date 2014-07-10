class FakeClient
  def initialize
    @admin = FakeAdmin.new.fake_admin
    @client = @admin.company.clients.create!({
      :user_id => user.id,
      :name => "New Client"
    })
  end

  def fake_admin
    @admin
  end

  def fake_client
    @client
  end
end