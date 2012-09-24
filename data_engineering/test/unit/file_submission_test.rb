require 'test_helper'

class FileSubmissionTest < ActiveSupport::TestCase
  include FileSubmissionTestHelper
  
  
  # make sure presence validation works
  test "should not save without a file" do
    assert !@file_submission.valid?,
      "File submission should not be valid without data_file"
    assert !@file_submission.save,
      "Saved the file submission without a file"
    assert_equal "can't be blank",
      @file_submission.errors[:data_file].join('')
  end
  
  # make sure file_submission is actually saving
  # with file
  test "should save with a file" do
    # set data file
    @file_submission.data_file = @data_file
    
    assert @file_submission.valid?,
      "File submission should be valid with data_file"
    
    assert @file_submission.save, 
      "Did not save the file submission with a file"    
  end
  
end
