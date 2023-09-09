require 'rails_helper'

RSpec.describe 'UserIndex', type: :feature do
  before do
    @user = User.create(name: 'test', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'bio1')
    @user2 = User.create(name: 'name2', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'bio2')
    @user.posts.create(title: 'post_title', text: 'post text')
    @user2.posts.create(title: 'post_title2', text: 'post text')
  end

  before :each do
    visit users_path
  end

  describe 'page display' do
    it 'I can see the username of all other users' do
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user2.name)
    end

    it 'I can see the profile picture for each user' do
      expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
    end

    it 'I can see the number of posts each user has written' do
      p @user.posts_counter, 'user1'
      p @user2.posts_counter, 'user2'
      expect(page).to have_content('1')
      expect(page).to have_content('1')
    end
  end

  describe 'user links' do
    it 'When I click on a user, I am redirected to that user\'s show page' do
      click_link(@user.name)
      expect(page).to have_current_path(user_path(@user))
    end
  end
end
