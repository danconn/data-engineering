require 'test_helper'

class FileSubmissionTest < ActiveSupport::TestCase
  # make sure presence validation works
  test "should not save without a file" do
    file_submission = FileSubmission.new
    assert !file_submission.save, "Saved the file submission without a file"
  end
  
  # make sure file_submission is actually saving
  # with file
  test "should save with a file" do
    file_submission = FileSubmission.new
    # get file in separate variable so we
    # can compare values later
    data_file = File.new('test/fixtures/files/example_input.tab')
    file_submission.data_file = data_file
    assert file_submission.save, "Did not save the file submission with a file"
    
    # make sure gross_revenue calculated is correct
    assert_equal 95.0, file_submission.gross_revenue
    
    
    
    # make sure file is closed
    data_file.close
  end
end
