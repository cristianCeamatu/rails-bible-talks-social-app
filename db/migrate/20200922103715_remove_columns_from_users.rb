class RemoveColumnsFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :photo
    remove_column :users, :coverImage
  end
end
