class Message  < ActiveRecord::Base
  include JsonSerializingModel
  has_one :photo
  has_one :user, as: :sender 
  has_many :users, as: :group 
  attr_accessible :data, :recipients, :sender, :created_at, :read_by_all
  before_save :set_recipients 

  def set_recipients
    unless @recipients 
      UserMessage.create!(:user => sender, :message => self, :read => true)
      @recipients = group.where('id != ?', sender.id)
      @recipients.each { |r| UserMessage.create!(:user => r, :message => self)} 
    end 
  end 

  def read_by_all 
    unless @read_by_all 
      lock = true 
      @recipients.each { |r| lock = false unless (UserMessage.where(:user => r, :message => self).first_or_create.read) } 
      @read_by_all = lock 
    end 
  end 
end 