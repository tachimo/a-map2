class CreateMarkers < ActiveRecord::Migration[8.1]
  def change
    create_table :markers do |t|
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
