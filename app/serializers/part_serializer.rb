class PartSerializer < ApplicationSerializer
  belongs_to :company
  belongs_to :manager
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :reports
  has_and_belongs_to_many :users_reports 

  attributes :barcode, :name
end
