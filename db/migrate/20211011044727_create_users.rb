class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, varchar: 255, null: false
      t.string :email, varchar: 255, null: false
      t.string :password_digest, varchar: 255, null: false
      t.string :profile , varchar: 255, null: false
      t.integer :type ,:limit=>1, null: false
      t.string :phone, varchar: 20
      t.string :address, varchar: 255
      t.date :dob
      t.integer :create_user_id, null: false
      t.integer :updated_user_id, null: false
      t.integer :deleted_user_id
      t.datetime :deleted_at
      t.timestamps 
    end
  end
end
