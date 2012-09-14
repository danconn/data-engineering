class AddAttachmentDataFileToFileSubmissions < ActiveRecord::Migration
  def self.up
    change_table :file_submissions do |t|
      t.has_attached_file :data_file
    end
  end

  def self.down
    drop_attached_file :file_submissions, :data_file
  end
end
