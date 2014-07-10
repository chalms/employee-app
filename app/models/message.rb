class Message  < ActiveRecord::Base
  include JsonSerializingModel
  has_one :photo
  belongs_to :user
  belongs_to :chat
  has_many :users_messages, as: :group
  attr_accessible :data, :recipients, :sender, :created_at, :read_by_all, :chat_id
  before_save :set_recipients

  def sender
    @sender ||= self.user
  end

  def set_recipients
    unless @recipients
      UsersMessage.create!(:user => sender, :message => self, :read => true)
      @recipients = chat.users_chats.where('user_id != ?', sender.id)
      @recipients.each { |r| UsersMessage.create!({:user => r, :message => self})}
    end
  end

  def read_by_all
    unless @read_by_all
      lock = true
      @recipients.each { |r| lock = false unless (UsersMessage.where(:user => r, :message => self).first_or_create.read) }
      @read_by_all = lock
    end
  end
end