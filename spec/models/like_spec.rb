# refactor from minitest file: ../../test/models/like_test.rb to spec file: ../../spec/models/like_spec.rb

require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it { should belong_to(:author) }
    it { should belong_to(:post) }
  end

  describe 'methods' do
    describe '#update_likes_counter_on_create' do
      it 'should increment likes_counter on post' do
        user = User.create(name: 'John')

        post = Post.create(title: 'Hello', author: user)

        Like.create(author: user, post:)

        expect(post.likes_counter).to eq(1)
      end
    end

    describe '#update_likes_counter_on_destroy' do
      it 'should decrement likes_counter on post' do
        user = User.create(name: 'John')

        post = Post.create(title: 'Hello', author: user)

        like = Like.create(author: user, post:)
        like.destroy

        expect(post.likes_counter).to eq(0)
      end
    end
  end
end
