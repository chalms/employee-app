class PartSerializer < ApplicationSerializer

  has_many :reports_parts
  has_many :users_reports, :through => :reports_parts
  has_many :reports, :through => :users_reports
  has_many :projects, :through => :reports
  attributes :barcode, :name, :manager_id, :assignment, :owners

end
