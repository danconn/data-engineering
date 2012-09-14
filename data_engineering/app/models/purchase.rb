class Purchase < ActiveRecord::Base
  belongs_to :item
  belongs_to :purchaser
  attr_accessible :count, :purchaser_id, :item_id
end
