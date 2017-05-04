class User < ApplicationRecord
  has_many :works
  has_many :votes
  has_many :ranked_works, through: :votes, source: :work

  validates :username, uniqueness: true, presence: true

  def self.build_user auth_hash
    user = User.new
    if auth_hash[:provider] == 'github'
      user.username = auth_hash['info']['nickname']
    elsif auth_hash[:provider] == 'google_oauth2'
      user.username = auth_hash['info']['name']
    end
    user.email = auth_hash['info']['email']
    user.uid = auth_hash['uid']
    user.provider = auth_hash['provider']

    user.save ? user : nil
  end
end
