class FileSubmissionsController < ApplicationController
  def index
    @file_submissions = FileSubmission.all
  end

  def new
    @file_submission = FileSubmission.new
  end
  
  def create
    @file_submission = FileSubmission.new(params[:file_submission])
    if @file_submission.save
      flash[:notice] = "You just uploaded $#{@file_submission.gross_revenue} " + 
        "worth of transactions"
      redirect_to file_submissions_path
    else
      # go back to new so we can see
      # error messages - YAY!
      render "new"
    end
  end
end
