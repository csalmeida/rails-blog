class User < ApplicationRecord
  has_secure_password
  has_many :articles, dependent: :destroy
  # has_many :comments, through: :articles

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
