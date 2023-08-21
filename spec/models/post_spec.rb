# refactor from minitest file: ../../test/models/post_test.rb to spec file: ../../spec/models/post_spec.rb

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should belong_to(:author) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe 'methods' do
    describe '#five_most_recent_comments' do
      it 'should fetch five most recent comments' do
        user = User.create(name: 'John')

        post = Post.create(title: 'Hello', author: user)

        _comment1 = Comment.create(author: user, post:, text: 'Hi')
        comment2 = Comment.create(author: user, post:, text: 'Hi')
        comment3 = Comment.create(author: user, post:, text: 'Hi')
        comment4 = Comment.create(author: user, post:, text: 'Hi')
        comment5 = Comment.create(author: user, post:, text: 'Hi')
        comment6 = Comment.create(author: user, post:, text: 'Hi')

        expect(post.five_most_recent_comments).to eq([comment6, comment5, comment4, comment3, comment2])
      end
    end

    describe '#update_posts_counter_on_create' do
      it 'should increment posts_counter on author' do
        user = User.create(name: 'John')

        Post.create(title: 'Hello', author: user)

        expect(user.posts_counter).to eq(1)
      end
    end

    describe '#update_posts_counter_on_destroy' do
      it 'should decrement posts_counter on author' do
        user = User.create(name: 'John')

        post = Post.create(title: 'Hello', author: user)
        post.destroy

        expect(user.posts_counter).to eq(0)
      end
    end
  end
end
