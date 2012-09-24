require 'test_helper'

class FileImporterTest < ActiveSupport::TestCase
  include FileSubmissionTestHelper
  
  def setup
    # run setup from included module
    super
    
    # set data file
    @file_submission.data_file = @data_file
    
    # save file
    @file_submission.save
  end
  
  # make sure file_importer.rb is normalizing data into
  # separate tables and inserting the correct number
  # of records.
  test "should normalize data submission" do
    
    # get count after saving file
    assert_equal 3, Merchant.count,
      "There should be 3 merchants"
    assert_equal 3, Purchaser.count,
      "There should be 3 purchasers"
    assert_equal 3, Item.count,
      "There should be 3 non-dup items"
    assert_equal 4, Purchase.count,
      "There should be 4 purchases"
  end
  
  # make sure data inserted into db
  # matches what we know is in test file
  test "should match file data" do
    # brute force call the records
    # created and check values; maybe a
    # fancier way to do this with fixtures
    # or something but I dunno...
    [
      { :name => "Bob's Pizza",:address => "987 Fake St" },
      { :name => "Tom's Awesome Shop",:address => "456 Unreal Rd" },
      { :name => "Sneaker Store Emporium",:address => "123 Fake St" }
    ].each do |row|
      assert Merchant.exists?(:name => row[:name], 
        :address => row[:address]),
        "Merchant with name => #{row[:name]} and "+
        "address => #{row[:address]} was not imported"
    end
    
    [
      { :name => "Snake Plissken" },
      { :name => "Amy Pond"},
      { :name => "Marty McFly" }
    ].each do |row|
      assert Purchaser.exists?(:name => row[:name]),
        "Purchaser with name => #{row[:name]} was not imported"
    end
    
    [
      { :description => "$10 off $20 of food",:price => 10.00,:merchant_id => 1 },
      { :description => "$30 of awesome for $10",:price => 10.00,:merchant_id => 2 },
      { :description => "$20 Sneakers for $5",:price => 5.00,:merchant_id => 3 }
    ].each do |row|
      assert Item.exists?(:description => row[:description],
        :price => row[:price], :merchant_id => row[:merchant_id]),
        "Item with description => #{row[:description]} and "+
        "price => #{row[:price]} was not imported"
    end
    
    [
      { :count => 2,:item_id => 1,:purchaser_id => 1 },
      { :count => 5,:item_id => 2,:purchaser_id => 2 },
      { :count => 1,:item_id => 3, :purchaser_id => 3 },
      { :count => 4,:item_id => 3,:purchaser_id => 1 }
    ].each do |row|
      assert Purchase.exists?(:count => row[:count],
      :item_id => row[:item_id], :purchaser_id => row[:purchaser_id]),
        "Purchase with count => #{row[:count]} was not imported"
    end
  end
  
  # was going to test to make sure duplicates
  # weren't inserted for Merchants, Purchasers,
  # and items but ran out of time
end