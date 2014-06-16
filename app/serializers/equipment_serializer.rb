class EquipmentSerializer < ApplicationSerializer
  attributes :id, :note, :description, :part_name, :scanned_at, :completed, :published_at
  belongs_to :report 
end
