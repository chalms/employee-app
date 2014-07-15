class UsersReport < ActiveRecord::Base
  include JsonSerializingModel
  attr_accessible :complete, :checkin, :checkout, :parts, :tasks, :location, :date, :hours, :employee, :manager, :report_id, :user_id, :chat_id

  belongs_to :report
  belongs_to :user
  has_many :reports_parts
  has_many :reports_tasks
  has_one :chat
  has_and_belongs_to_many :locations
  after_create :create_chat
  TYPES = ['UsersReportsChat', 'ReportsChat']

  def create_chat
    # NEEDS TO BE SPED UP
    chat = Chat.joins(:users_chats).where('user_id = ? OR user_id = ?', user.id, manager_id).andand.first
    unless !!chat
      chat = UsersReportsChat.create!({:type => TYPES[0], :users_report_id => self.id, :name => "#{employee.name} & #{manager.name}"})
      employee.users_chats.where({:chat_id => chat.id}).first_or_create!
      chat.users_chats.create!({:user_id => employee.id})
      manager.users_chats.where({:chat_id => chat.id}).first_or_create!
      chat.users_chats.create!({:user_id => manager.id})
    end
    update_attribute(:chat_id, chat.id)
  end

  def date
    @date ||= report.date
  end

  def manager
    @manager ||= User.find(report.manager_id)
    if (@manager.present?)
      raise Exceptions::StdError, "User report cant find manager!" if (@manager.role == 'employee')
    end
    @manager
  end

  def employee
    @employee ||= self.user
    @employee ||= User.find(self.user_id)
    @employee
  end

  def hours
    @hours = 0
    return @hours unless (checkin.present? && checkout.present?)
    @hours = (checkin - checkout)/1.hour
  end

  def parts
    reports_parts.map { |q| q.part }
  end

  def tasks
    reports_tasks.map { |q| q.task }
  end

  def add_reports_task(reports_task)
    reports_tasks.where(id: reports_tasks.id).first_or_create
  end

  def add_reports_part(reports_part)
    reports_parts.where(id: reports_parts.id).first_or_create
  end

  def add_task(task_id)
    return reports_tasks.where(task_id: task_id).first_or_create
  end

  def add_part(part_id)
    return reports_parts.where(part_id: part_id).first_or_create
  end

  def incomplete_parts
    return reports_parts.where(:complete => false)
  end

  def incomplete_tasks
    return reports_tasks.where(:complete => false)
  end

  def self.completed_parts
    return reports_parts.where(:complete => true)
  end

  def self.completed_tasks
    return reports_tasks.where(:complete => true)
  end

  def self.complete?
    @complete ||= if (reports_parts.where(:complete => false) && reports_tasks.where(:complete => false))
        false
      else
        self.update_attributes(:complete => true)
        true
      end
  end
end