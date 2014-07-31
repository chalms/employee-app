class Item < ActiveRecord::Base
  has_ancestry
  attr_accessible :data
end
