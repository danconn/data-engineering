module FileSubmissionTestHelper
  def setup
    @file_submission = FileSubmission.new
    @data_file = File.new('test/fixtures/files/example_input.tab')
  end
  
  def teardown
    # get rid of the file the test <em>may</em>
    # have created
    remove_test_upload_file(@file_submission)
    # make sure file is closed
    @data_file.close
  end
end