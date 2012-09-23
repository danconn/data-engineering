ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  
  # to be called after file test is run to
  # get rid of the file so we don't get a futre
  # false positive on a file that exists
  def remove_test_upload_file(file_submission)
    if File.exists?(file_submission.data_file.path)
      require 'fileutils'
      FileUtils.rm_rf(File.join(Rails.root, 'test/fixtures/paperclip_files/file_submissions'))
    end
  end
  
end
