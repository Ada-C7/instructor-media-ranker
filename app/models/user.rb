class User < ApplicationRecord
  has_many :votes
  has_many :ranked_works, through: :votes, source: :work

  validates :email, uniqueness: true, presence: true

  def self.create_from_omniauth(auth_hash)
    User.create(
      name: auth_hash["info"]["name"],
      provider: auth_hash["provider"],
      uid: auth_hash["uid"],
      email: auth_hash["info"]["email"]
    )
  end
end
