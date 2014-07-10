class CreateClient
  def initialize(user)
    @user = user
    @client = user.company.clients.create!({
      :user_id => user.id,
      :name => "New Client"
    })
  end

  def client
    @client ||= @user.company.clients.create!({
      :user_id => user.id,
      :name => "New Client"
    })
  end
end