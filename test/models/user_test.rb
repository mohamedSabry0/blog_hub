require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should not save user without name' do
    user = User.new
    assert_not user.save
  end

  test 'should save user with name' do
    user = User.new
    user.name = 'John'
    assert user.save
  end

  test 'should not save user with negative posts_counter' do
    user = User.new
    user.name = 'John'
    user.posts_counter = -1
    assert_not user.save
  end

  test 'should not save user with fractional posts_counter' do
    user = User.new
    user.name = 'John'
    user.posts_counter = 1.5
    assert_not user.save
  end

  test 'should fetch three most recent posts' do
    user = User.create(name: 'John')

    _post1 = Post.create(title: 'Hello', author: user)
    post2 = Post.create(title: 'World', author: user)
    post3 = Post.create(title: '!', author: user)
    post4 = Post.create(title: '!', author: user)

    assert_equal user.three_most_recent_posts, [post4, post3, post2]
  end
end
