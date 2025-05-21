class AddDescriptionToRooms < ActiveRecord::Migration[8.0]
  def change
    add_column :rooms, :description, :text
  end
end
