class FakeChats

  def initialize(user_reports)
    # Algorithm to build chats for each user_report if a chat does
    # not exist between its members
    # @chats = []
    # @conversations = []

    # user_reports.each do |u_r|

    #   users = u_r.employees
    #   users << u_r.manager
    #   count = -1
    #   chat_list = []

    #   users.each do |u|
    #     if (u.chats.count < count || count == -1)
    #       count = u.chats.count
    #       chat_list = u.chats
    #     end
    #   end

    #   cut_list = []
    #   chat_list.each do |chat|
    #     cut_list << chat if (chat.users_chats.count == users.count)
    #   end

    #   the_chat = nil

    #   cut_list.each do |chat|
    #     i = 0
    #     chat.users_chats.each do |users_chat|
    #       if ( users.include? (users_chat.user) )
    #         i += 1
    #       else
    #         break
    #       end
    #     end

    #     if (i == users.count)
    #       the_chat = chat
    #       break
    #     end
    #   end

    #   the_chat = Chat.create!(:company_id => u_r.company.id) unless (the_chat)

    #   users.each do |u|
    #     the_chat.users_chats.create!(:user_id => u.id)
    #   end

    #   @chats << the_chat
    # end

    # @chats.each do |chat|
    #   @conversations << FakeConversation.new(chat).fake_conversation
    # end
  end

  def fake_chats
    @chats
  end

  def fake_conversation
    @conversations
  end

end


