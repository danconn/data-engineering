class Item < ActiveRecord::Base
  belongs_to :merchant
  attr_accessible :description, :price, :merchant_id
end
