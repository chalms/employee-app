class UserReport < ActiveRecord::Base
  include JsonSerializingModel
  attr_accessible :complete, :checkin, :checkout, :parts, :tasks, :location, :date, :hours 
  belongs_to :report 
  belongs_to :user, as: :employee, :foreign_key => 'user_id'
  belongs_to :user, as: :manager, :foreign_key => 'user_id'
  has_many :report_parts 
  has_many :report_tasks 

  def hours
    @hours = 0 
    return @hours unless (checkin.present? && checkout.present?)
    @hours = (checkin - checkout)/1.hour 
  end 

  def parts 
    report_parts 
  end 

  def tasks
    report_tasks
  end 

  def add_report_task(report_task)
    report_tasks.where(id: report_tasks.id).first_or_create 
  end 

  def add_report_part(report_part)
    report_parts.where(id: report_parts.id).first_or_create 
  end 

  def add_task(task_id) 
    return report_tasks.where(task_id: task_id).first_or_create
  end 

  def add_part(part_id)
    return report_parts.where(part_id: part_id).first_or_create
  end

  def incomplete_parts 
    return report_parts.where(:complete => false)
  end 

  def incomplete_tasks 
    return report_tasks.where(:complete => false)
  end 

  def self.completed_parts 
    return report_parts.where(:complete => true)
  end 

  def self.completed_tasks 
    return report_tasks.where(:complete => true)
  end 

  def self.complete? 
    @complete ||= do 
      if (report_parts.where(:complete => false) && report_tasks.where(:complete => false))
        false 
      else 
        self.update_attributes(:complete => true)
        true 
      end 
    end 
  end 
end