require 'test_helper'

describe User do
  describe "relations" do
    it "has a list of votes" do
      dan = users(:dan)
      dan.must_respond_to :votes
      dan.votes.each do |vote|
        vote.must_be_kind_of Vote
      end
    end

    it "has a list of ranked works" do
      dan = users(:dan)
      dan.must_respond_to :ranked_works
      dan.ranked_works.each do |work|
        work.must_be_kind_of Work
      end
    end
  end

  describe "validations" do
    it "requires a email" do
      user = User.new
      user.valid?.must_equal false
      user.errors.messages.must_include :email
    end

    it "requires a unique email" do
      email = "test email"
      user1 = User.new(email: email)

      # This must go through, so we use create!
      user1.save!

      user2 = User.new(email: email)
      result = user2.save
      result.must_equal false
      user2.errors.messages.must_include :email
    end


  end
end
