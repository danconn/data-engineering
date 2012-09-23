class FileSubmission < ActiveRecord::Base
  attr_accessible :gross_revenue, :name, :data_file
  has_attached_file :data_file
  
  validates_attachment :data_file, :attachment_presence => true
  
  after_create do |record|
    # now use FileImporter class to do the dirty
    # work after the file has been uploaded/saved
    DataEngineering::FileImporter.new(record.data_file.queued_for_write[:original].path, record).import!
  end
  
end
