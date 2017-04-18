class User < ApplicationRecord
  has_many :votes
  has_many :ranked_works, through: :votes, source: :work
  # has_many :works

  validates :username, uniqueness: true, presence: true


  # def self.from_github(auth_hash)
  #
  #   user = User.new
  #
  #   user.username = auth_hash["info"]["nickname"]
  #   user.email = auth_hash["info"]["email"]
  #   user.oauth_uid = auth_hash["uid"]
  #   user.oauth_provider = "github"
  #   return user
  # end
  #
  # def self.from_google(auth_hash)
  #     user = User.new
  #     user.oauth_provider = "auth_hash.provider"
  #     user.oauth_uid = auth_hash["uid"]
  #
  #     user.username = auth_hash.info.name
  #
  #
  #     return user
  #
  # end


  def self.from_omniauth(auth_hash)

    user = User.new
    if auth_hash["info"]["nickname"] !=  nil
      user.username = auth_hash["info"]["nickname"]
    else
      user.username = auth_hash["info"]["email"]
    end
    user.email = auth_hash["info"]["email"]
    user.oauth_uid = auth_hash["uid"]
    user.oauth_provider = auth_hash[:provider]
    return user
  end
end
