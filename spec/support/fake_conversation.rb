class FakeConversation
  initialize(chat)
    @chat = chat
    @chat.users_chats.each do |u_c|
      if (u_c.user.role == 'manager')
        @chat.send_message("Hi! my name is #{u_c.user.name}")
      end
    end
  end
  def fake_conversation
    @chat
  end
end
