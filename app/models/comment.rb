class Comment < ApplicationRecord
  include Visible
  belongs_to :user
  belongs_to :article

  validates :status, presence: true
  validates :body, presence: true, length: { minimum: 10 }
end
