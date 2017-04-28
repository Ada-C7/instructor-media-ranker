class User < ApplicationRecord
  has_many :votes
  has_many :ranked_works, through: :votes, source: :work

  validates :provider, :email, :uid, :name, presence: true

  def self.create_from_oauth(auth_hash)
    user = User.new
    user.uid = auth_hash["uid"]
    user.provider = auth_hash["provider"]
    user.name = auth_hash["info"]["name"]
    user.email = auth_hash["info"]["email"]
    user.save
    return user
  end

end
