# integration tests for user show page
# I can see the user's profile picture.
# I can see the user's username.
# I can see the number of posts the user has written.
# I can see the user's bio.
# I can see the user's first 3 posts.
# I can see a button that lets me view all of a user's posts.
# When I click a user's post, it redirects me to that post's show page.
# When I click to see all posts, it redirects me to the user's post's index page

require 'rails_helper'

RSpec.describe 'UserShow', type: :feature do
  before do
    @user = User.create(name: 'test', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'test')
    @post = Post.create(title: 'post_title1', text: 'post text', author: @user)
    @post2 = Post.create(title: 'post_title2', text: 'post text', author: @user)
    @post3 = Post.create(title: 'post_title3', text: 'post text', author: @user)
    @comment = @post.comments.create(text: 'comment', author: @user)
    @comment2 = @post.comments.create(text: 'comment2', author: @user)
    @comment3 = @post.comments.create(text: 'comment3', author: @user)
    @comment4 = @post.comments.create(text: 'comment4', author: @user)
    @comment5 = @post.comments.create(text: 'comment5', author: @user)
    @comment6 = @post.comments.create(text: 'comment6', author: @user)
    @like = @post.likes.create(author: @user)
    @like2 = @post.likes.create(author: @user)
    @like3 = @post.likes.create(author: @user)
    visit user_path(@user)
  end

  describe 'page display' do
    it 'I can see the user\'s profile picture' do
      expect(page).to have_css("img[src*='#{@user.photo}']")
    end

    it 'I can see the user\'s username' do
      expect(page).to have_content(@user.name)
    end

    it 'I can see the number of posts the user has written' do
      expect(page).to have_content(@user.posts_counter)
    end

    it 'I can see the user\'s bio' do
      expect(page).to have_content(@user.bio)
    end

    it 'I can see the user\'s first 3 posts' do
      expect(page).to have_content(@post.title)
      expect(page).to have_content(@post2.title)
      expect(page).to have_content(@post3.title)
    end

    it 'I can see a button that lets me view all of a user\'s posts' do
      expect(page).to have_link('See all posts')
    end

    it 'when I click a user\'s post, it redirects me to that post\'s show page' do
      click_link @post.title
      expect(page).to have_current_path(user_post_path(@user, @post))
    end
  end
end
