class ClientsProject < ActiveRecord::Base
  belongs_to :client
  belongs_to :project
end
