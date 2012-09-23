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
    
    # make sure it was redirect to index
    assert_redirected_to file_submissions_path,
      "Create response was not redirected to the index page"
      
    # make sure the correct flash message was shown
    assert_equal "You just uploaded $#{assigns(:file_submission).gross_revenue} worth of transactions", 
      flash[:notice], "Success message was incorrect"
      
    # make sure file was uploaded
    full_path = assigns(:file_submission).data_file.path # get rid of some ugliness
    assert File.exists?(full_path),
      "File at #{full_path} does not exist on the server"
      
    # get rid of the file
    remove_test_upload_file(assigns(:file_submission))
  end
  
  # test failure scenario with no file
  test "should not create file submission without file" do
    # make sure a new file submission was not added
    # by checking the count
    assert_no_difference("FileSubmission.count") do
      post :create, :file_submission => {}
    end
    
    # make sure new view rendered
    assert_response :success
    assert_template 'file_submissions/new',
      "Create response did not render new view"
      
    # make sure flash message is nil
    assert_equal nil, 
      flash[:notice], "Success message was populated"
  end
  
  private
  
  # this should probably be moved to a teardown
  # but I couldn't find the rails testing equivalent
  # of context from Shoulda
  def remove_test_upload_file(file_submission)
    if File.exists?(file_submission.data_file.path)
      require 'fileutils'
      FileUtils.rm_rf(File.join(Rails.root, 'test/fixtures/paperclip_files/file_submissions'))
    end
  end
end
