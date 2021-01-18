class Comment < ApplicationRecord
  include Visible

  validates :commenter, presence: true
  validates :status, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  belongs_to :article
end
