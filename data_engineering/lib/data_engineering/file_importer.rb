require 'csv'

module DataEngineering
  class FileImporter
    def self.import!(filepath, file_submission)
      # iterate over each row of the csv data
      gross_revenue = 0
      CSV.foreach(filepath, :col_sep => "\t", :headers => true) do |row|
        
        # assuming it is a decent assumption that a merchant
        # with the same name and address is the same
        merchant = Merchant.where("name = ? AND address = ?", row['merchant name'], 
          row['merchant address']).first() ||
        Merchant.create({:name => row['merchant name'], 
            :address => row['merchant address']})
          
        # bad assumption but going to do it anyways:
        # purchaser with same name is same person
        purchaser = Purchaser.where("name = ?", row['purchaser name']).first() ||
          Purchaser.create({:name => row['purchaser name']})
        
        # assuming item with same description and price is same
        item = Item.where("description = ? AND price = ? AND merchant_id = ?", 
          row['item description'], row['item price'], merchant.id).first() || 
        Item.create({:description => row['item description'], 
          :price => row['item price'], :merchant_id => merchant.id})        
        
        
        # every purchase is unique; unless we want to track multiple
        # items purchased at one time
        purchase = Purchase.create({:count => row['purchase count'],
          :item_id => item.id, :purchaser_id => purchaser.id})
          
        # save
        merchant.save!
        purchaser.save!
        item.save!
        purchase.save!
        
        # add to gross revenue
        gross_revenue += (item.price * purchase.count) 
      end
      # set total amount
      file_submission.update_attribute(:gross_revenue, gross_revenue)
    end
  end
end