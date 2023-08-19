# refactor from minitest file: ../../test/models/comment_test.rb to spec file: ../../spec/models/comment_spec.rb

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:author) }
    it { should belong_to(:post) }
  end

  describe 'methods' do
    describe '#update_comments_counter_on_create' do
      it 'should increment comments_counter on post' do
        user = User.create(name: 'John')

        post = Post.create(title: 'Hello', author: user)

        Comment.create(author: user, post:, text: 'Hi')

        expect(post.comments_counter).to eq(1)
      end
    end

    describe '#update_comments_counter_on_destroy' do
      it 'should decrement comments_counter on post' do
        user = User.create(name: 'John')

        post = Post.create(title: 'Hello', author: user)

        comment = Comment.create(author: user, post:, text: 'Hi')
        comment.destroy

        expect(post.comments_counter).to eq(0)
      end
    end
  end
end
