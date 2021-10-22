class ChangeDeleteat < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :deleted_at, :datetime, :precision => 6
  end
end
