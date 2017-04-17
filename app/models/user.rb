class User < ApplicationRecord
  has_many :votes
  has_many :ranked_works, through: :votes, source: :work

  # validates :username, uniqueness: true, presence: true
  # validates :uid, presence: true
  # validates :provider, presence: true
  # validates :email, presence: true
end
