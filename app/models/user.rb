class User < ApplicationRecord
  has_many :votes
  has_many :ranked_works, through: :votes, source: :work

  # validates :username, uniqueness: true, presence: true
  # validates :uid, presence: true
  # validates :provider, presence: true
  # validates :email, presence: true

  def self.create_from_github(auth_hash)
    user = User.new
    user.uid = auth_hash["uid"]
    user.provider = auth_hash["provider"]
    user.username = auth_hash["info"]["name"] || "Stanley"
    user.email = auth_hash["info"]["email"]
    user.save ? user : nil
end
