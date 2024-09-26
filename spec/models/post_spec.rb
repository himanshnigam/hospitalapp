require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'checking for validations' do
    let(:post) { build :post }

    it 'is valid with all attributes' do
      expect(post).to be_valid
    end

    it 'is invalid without a title' do
      post.title = nil
      expect(post).to_not be_valid
    end

    it 'is invalid without a body' do
      post.body = nil
      expect(post).to_not be_valid
    end

    it 'belongs to a user' do
      expect(post.user).to be_present
    end
  end

  context 'checking the associations of this model' do
    let(:post) { create(:post) }
    let(:user) { post.user }
    let(:comment1) { create(:comment, post: post) }
    let(:comment2) { create(:comment, post: post) }

    it 'iwhether this belongs to a user' do
      expect(post.user).to be_a(User)
    end

    it 'if it has many comments' do
      expect(post.comments).to include(comment1, comment2)
    end

    it 'if the post is deletd when the comment is deleted' do
      post.destroy
      expect(Post.count).to eq(0)
      expect(Comment.count).to eq(0)
    end
  end
end
