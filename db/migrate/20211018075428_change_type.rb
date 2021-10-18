class ChangeType < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :create_user_id, :bigint
  end
end
