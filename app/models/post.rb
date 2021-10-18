class Post < ApplicationRecord
  belongs_to :create_user, class_name: 'User' 
  belongs_to :updated_user, class_name: 'User'

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :status, presence: true
  validates :create_user_id, presence: true
  validates :updated_user_id, presence: true
end
