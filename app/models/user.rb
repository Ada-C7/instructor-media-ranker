class User < ApplicationRecord
  has_many :works
  has_many :votes
  has_many :ranked_works, through: :votes, source: :work

  validates :uid, presence: true, uniqueness: true
  validates :provider, presence: true
  validates :username, uniqueness: true, presence: true

  def self.create_from_github(auth_hash)
    user = User.new
    user.uid = auth_hash["uid"]
    user.provider = auth_hash["provider"]
    user.name = auth_hash["info"]["name"]
    user.email = auth_hash["info"]["email"]

    user.save ? user : nil
  end
end
