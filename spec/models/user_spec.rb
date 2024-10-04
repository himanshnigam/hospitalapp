require 'rails_helper'

RSpec.describe User, type: :model do
  context 'checking for validations for user model for creating' do
    let(:user) { build :user }
    let(:user1) { build :user, email: user.email }

    it 'is valid with all attributes' do
      expect(user).to be_valid
    end

    it 'is invalid without an email' do
      user.email = nil
      expect(user).to_not be_valid
    end

    it 'is invalid without a username' do
      user.username = nil
      expect(user).to_not be_valid
    end

    it 'is invalid if password is too short' do
      user.password = '12345'
      expect(user).to_not be_valid
    end

    it 'should return invalid output for both users having same email' do
      user.save
      expect(user1.save).to eq(false)
    end
  end

  context 'checking for association of this user model' do
    let(:user) { create(:user) }
    let(:post1) { create(:post, user: user) }
    let(:post2) { create(:post, user: user) }
    let(:post) { create(:post, user: user) }
    let(:comment1) { create(:comment, user: user, post: post) }
    let(:comment2) { create(:comment, user: user, post: post) }

    it 'if it has many posts' do
      expect(user.posts).to include(post1, post2)
    end

    it 'if it has many comments' do
      expect(user.comments).to include(comment1, comment2)
    end

    it 'if the associated posts are deleted when the user is deleted' do
      user.destroy
      expect(User.count).to eq(0)
      expect(Post.count).to eq(0)
    end
  end
end
