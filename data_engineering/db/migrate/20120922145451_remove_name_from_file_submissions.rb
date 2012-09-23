class RemoveNameFromFileSubmissions < ActiveRecord::Migration
  def up
    remove_column :file_submissions, :name
  end

  def down
    add_column :file_submissions, :name, :string
  end
end
