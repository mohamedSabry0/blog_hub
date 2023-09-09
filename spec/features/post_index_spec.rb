require 'rails_helper'

RSpec.describe 'PostIndex', type: :feature do
  before :each do
    @user = User.create(name: 'test', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'test')
    @post = Post.create(title: 'post_title2', text: 'post text', author: @user)
    visit user_posts_path(@user)
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

    it 'I can see a post\'s title' do
      expect(page).to have_content(@post.title)
    end

    it 'I can see some of the post\'s body' do
      expect(page).to have_content(@post.text)
    end

    it 'I can see the first comments on a post' do
      @post.comments.create(text: 'comment', author: @user)
      @post.comments.create(text: 'comment2', author: @user)
      visit user_posts_path(@user)
      @post.comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end

    it 'I can see how many comments a post has' do
      expect(page).to have_content(@post.comments_counter)
    end

    it 'I can see how many likes a post has' do
      expect(page).to have_content(@post.likes_counter)
    end

    it 'I can see a section for pagination if there are more posts than fit on the view' do
      expect(page).to have_css('div.pagination')
    end
  end

  describe 'post links' do
    it 'When I click on a post, it redirects me to that post\'s show page' do
      click_link @post.title
      expect(current_path).to eq(user_post_path(@user, @post))
    end
  end
end
