# integration tests for post show page
# the below cases are tested:
# I can see the post's title.
# I can see who wrote the post.
# I can see how many comments it has.
# I can see how many likes it has.
# I can see the post body.
# I can see the username of each commentor.
# I can see the comment each commentor left.

require 'rails_helper'

RSpec.describe 'PostShow', type: :feature do
  before :each do
    @user = User.create(name: 'test', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'test')
    @post = Post.create(title: 'test', text: 'test', author: @user)
    @comment = @post.comments.create(text: 'test', author: @user)
    @comment2 = @post.comments.create(text: 'test2', author: @user)
    @comment3 = @post.comments.create(text: 'test3', author: @user)
    @like = @post.likes.create!(author_id: @user.id)
    visit user_post_path(@user, @post)
  end

  describe 'page display' do
    it 'I can see the post\'s title' do
      expect(page).to have_content(@post.title)
    end

    it 'I can see who wrote the post' do
      expect(page).to have_content(@post.author.name)
    end

    it 'I can see how many comments it has' do
      expect(page).to have_content(@post.comments_counter)
    end

    it 'I can see how many likes it has' do
      expect(page).to have_content(@post.likes_counter)
    end

    it 'I can see the post body' do
      expect(page).to have_content(@post.text)
    end

    it 'I can see the username of each commentor' do
      expect(page).to have_content(@comment.author.name)
      expect(page).to have_content(@comment2.author.name)
      expect(page).to have_content(@comment3.author.name)
    end

    it 'I can see the comment each commentor left' do
      expect(page).to have_content(@comment.text)
      expect(page).to have_content(@comment2.text)
      expect(page).to have_content(@comment3.text)
    end
  end
end
