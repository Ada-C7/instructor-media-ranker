class User < ApplicationRecord
  has_many :votes
  has_many :ranked_works, through: :votes, source: :work

  validates :username, uniqueness: true, presence: true

  def self.owns_work(work, user)
    work.user.id == user.id if work.user_id
  end

  def self.create_from_github(auth_hash)
    user = User.new
    user.uid = auth_hash["uid"]
    user.provider = auth_hash["provider"]
    user.email = auth_hash["info"]["email"]
    user.name = auth_hash["info"]["name"]
    if auth_hash["info"]["nickname"]
      user.username = auth_hash["info"]["nickname"]
    else
      user.username = "user#{user.id}"
    end

    user.save ? user : nil
  end
end
