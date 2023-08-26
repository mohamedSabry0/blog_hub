require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before(:each) do
    @user = User.create(name: 'John')
  end

  describe 'GET users/:id/posts' do
    it 'response status is correct' do
      get user_posts_path(@user)
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get user_posts_path(@user)
      expect(response).to render_template(:index)
    end

    it 'renders the correct content' do
      get user_posts_path(@user)
      expect(response.body).to include('here is a list of posts')
    end
  end

  describe 'GET users/:id/posts/:id' do
    before(:each) do
      @post = Post.create(title: 'Hello', author: @user)
    end
    it 'response status is correct' do
      get user_post_path(@user, @post)
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get user_post_path(@user, @post)
      expect(response).to render_template(:show)
    end

    it 'renders the correct content' do
      get user_post_path(@user, @post)
      expect(response.body).to include('here is the post')
    end
  end
end
