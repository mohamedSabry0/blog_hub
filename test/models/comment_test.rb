require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'should not save comment without user' do
    comment = Comment.new
    assert_not comment.save
  end

  test 'should not save comment without post' do
    comment = Comment.new
    assert_not comment.save
  end

  test 'should save comment with user and post' do
    comment = Comment.new
    comment.author = User.new
    comment.post = Post.new
    assert comment.save
  end

  test 'should not save comment with user and without post' do
    comment = Comment.new
    comment.author = User.new
    assert_not comment.save
  end

  test 'should not save comment without user and with post' do
    comment = Comment.new
    comment.post = Post.new
    assert_not comment.save
  end
end
