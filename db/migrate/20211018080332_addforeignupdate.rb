class Addforeignupdate < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :updated_user_id, :bigint
  end
end
