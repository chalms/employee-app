class TaskSerializer < ApplicationSerializer
  belongs_to :manager 
  belongs_to :company
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :reports
  has_and_belongs_to_many :user_reports 
  attributes :description
end
