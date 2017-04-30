class User < ApplicationRecord
  has_many :votes
  has_many :ranked_works, through: :votes, source: :work


  def self.create_from_github(auth_hash)
    user = User.new
    user.uid = auth_hash["uid"]
    user.provider = auth_hash["provider"]
    user.name = auth_hash["info"]["name"]
    user.email = auth_hash["info"]["email"]

    user.save ? user : nil
  end
end
