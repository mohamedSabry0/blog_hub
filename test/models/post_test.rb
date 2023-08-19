require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'should not save post without title' do
    post = Post.new
    assert_not post.save
  end

  test 'should not save post without author' do
    post = Post.new
    assert_not post.save
  end

  test 'should not save post with title and without author' do
    post = Post.new
    post.title = 'Hello'
    assert_not post.save
  end

  test 'should not save post without title and with author' do
    post = Post.new
    user = User.new(name: 'John')
    post.author = user
    assert_not post.save
  end

  test 'should save post with title and author' do
    post = Post.new
    post.title = 'Hello'
    user = User.new(name: 'John')
    post.author = user
    assert post.save
  end

  test 'should fetch five most recent comments' do
    user = User.create(name: 'John')

    post = Post.create(title: 'Hello', author: user)

    _comment1 = Comment.create(author: user, post:, text: 'Hi')
    comment2 = Comment.create(author: user, post:, text: 'Hi')
    comment3 = Comment.create(author: user, post:, text: 'Hi')
    comment4 = Comment.create(author: user, post:, text: 'Hi')
    comment5 = Comment.create(author: user, post:, text: 'Hi')
    comment6 = Comment.create(author: user, post:, text: 'Hi')

    assert_equal post.five_most_recent_comments, [comment6, comment5, comment4, comment3, comment2]
  end
end
