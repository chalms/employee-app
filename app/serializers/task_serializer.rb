class TaskSerializer < ApplicationSerializer
  attributes :id, :note, :description, :completed, :report_index
end
