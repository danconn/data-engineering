class CreateFileSubmissions < ActiveRecord::Migration
  def change
    create_table :file_submissions do |t|
      t.string :name
      t.decimal :gross_revenue, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
