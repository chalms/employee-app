class TaskSerializer < ApplicationSerializer
  attributes :id, :note, :description, :completed_at, :completed, :published_at
  belongs_to :report 
end
