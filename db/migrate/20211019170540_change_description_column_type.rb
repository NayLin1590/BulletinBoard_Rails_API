class ChangeDescriptionColumnType < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :description, :text, :limit => 4294967295
  end
end
