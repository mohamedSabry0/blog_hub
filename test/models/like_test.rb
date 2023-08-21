require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  test 'should not save like without user' do
    like = Like.new
    assert_not like.save
  end

  test 'should not save like without post' do
    like = Like.new
    assert_not like.save
  end

  test 'should save like with user and post' do
    like = Like.new
    like.author = User.new
    like.post = Post.new
    assert like.save
  end

  test 'should not save like with user and without post' do
    like = Like.new
    like.author = User.new
    assert_not like.save
  end

  test 'should not save like without user and with post' do
    like = Like.new
    like.post = Post.new
    assert_not like.save
  end
end
