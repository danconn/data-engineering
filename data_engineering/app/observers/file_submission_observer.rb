class FileSubmissionObserver < ActiveRecord::Observer
  def after_create(record)
    # now use FileImporter class to do the dirty
    # work after the file has been uploaded/saved
    DataEngineering::FileImporter.new(record.data_file
      .queued_for_write[:original].path, record).import!
  end
end