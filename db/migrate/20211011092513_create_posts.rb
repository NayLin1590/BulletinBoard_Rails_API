class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title , varchar: 255 , null: false
      t.string :description, null: false
      t.integer :status , :limit=>1 , null: false
      t.integer :create_user_id , null: false
      t.integer :updated_user_id , null: false
      t.integer :deleted_user_id
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
