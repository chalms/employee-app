class TaskSerializer < ApplicationSerializer
  attributes :id, :note, :description, :completed_at, :completed, :published_at
  has_one :report 
end
