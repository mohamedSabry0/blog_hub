# refactor from minitest file: ../../test/models/user_test.rb to spec file: ../../spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:posts_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe 'methods' do
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

    describe '#three_most_recent_posts' do
      it 'should fetch three most recent posts' do
        user = User.create(name: 'John')

        _post1 = Post.create(title: 'Hello', author: user)
        post2 = Post.create(title: 'World', author: user)
        post3 = Post.create(title: '!', author: user)
        post4 = Post.create(title: '!', author: user)

        expect(user.three_most_recent_posts).to eq([post4, post3, post2])
      end
    end
  end
end
