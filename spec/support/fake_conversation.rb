class FakeConversation
  def initialize(chat)
    @chat = chat
    @chat.users_chats.each do |u_c|
      puts u_c.inspect
      user = User.find(u_c.user_id)
      if (user.role == 'manager')
        @chat.send_message("Hi! my name is #{u_c.user.name}",nil, user.id )
      end
    end
  end

  def fake_conversation
    @chat
  end
end
