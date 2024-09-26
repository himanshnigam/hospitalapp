require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'checking for validations' do
    let(:comment) { build :comment }

    it 'is valid with all attributes' do
      expect(comment).to be_valid
    end

    it 'is invalid without a description' do
      comment.description = nil
      expect(comment).to_not be_valid
    end

    it 'belongs to a post' do
      expect(comment.post).to be_present
    end

    it 'belongs to a user' do
      expect(comment.user).to be_present
    end
  end

  context 'checking the associations for comment model' do
    let(:comment) { create(:comment) }
    let(:post) { comment.post }
    let(:user) { comment.user }

    it 'if it belongs to a post' do
      expect(comment.post).to be_a(Post)
    end

    it 'if it belongs to a user' do
      expect(comment.user).to be_a(User)
    end
  end
end
