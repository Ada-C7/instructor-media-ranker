class User < ApplicationRecord
  has_many :votes
  has_many :ranked_works, through: :votes, source: :work
  has_many :works

  validates :username, uniqueness: true, presence: true

  def self.build_from_github auth_hash

    User.create(uid: auth_hash["uid"],
                provider: auth_hash["provider"],
                email: auth_hash["info"]["email"],
                username: auth_hash["info"]["name"])
    user.save ? user : nil


  end
end
