require 'test_helper'

class FileSubmissionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end
  
  # test success scenario with file
  test "should create file submission with file" do
    # make sure a new file submission was added
    # by checking the count
    assert_difference("FileSubmission.count") do
      post :create, :file_submission => { 
        :data_file => fixture_file_upload('files/example_input.tab','text/plain')
      }
    end
    
    # test assignment of file_submission
    file_submission = assigns(:file_submission)
    assert_not_nil file_submission, "File submission from assigns is nil"
    
    # test file_submission equals one from db
    new_file_submission = FileSubmission.find(file_submission.id)
    assert_equal file_submission, new_file_submission,
      "File submissions do not match"
    
      # make sure the correct flash message was shown
    assert_equal "You just uploaded $#{file_submission.gross_revenue} worth of transactions", 
      flash[:notice], "Success message was incorrect"
    
    # make sure it was redirect to index
    assert_redirected_to file_submissions_path,
      "Create response was not redirected to the index page"
      
    # make sure file was uploaded
    full_path = file_submission.data_file.path # get rid of some ugliness
    assert File.exists?(full_path),
      "File at #{full_path} does not exist on the server"
      
    # get rid of the file (should be moved
    # to some sort of teardown, but this
    # is the onyl test that should need it)
    remove_test_upload_file(file_submission)
  end
  
  # test failure scenario with no file
  test "should not create file submission without file" do
    # make sure a new file submission was not added
    # by checking the count
    assert_no_difference("FileSubmission.count") do
      post :create, :file_submission => {}
    end
    
    # test no id was assigned
    assert_nil assigns(:file_submission).id,
      "File submission should not have an id"
    
    # make sure new view rendered
    assert_response :success, "Did not respond with 200 status"
    assert_template 'file_submissions/new', 
      "Create response did not render new view"
      
    # make sure flash message is nil
    assert_equal nil, flash[:notice], "Success message was populated"
    
    # check error message
    assert_select 'li', :content => "Data file can&#x27;t be blank"
  end  
  
end
