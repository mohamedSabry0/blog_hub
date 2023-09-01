require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    it 'response status is correct' do
      get users_path
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'renders the correct content' do
      get users_path
      expect(response.body).to include('Users')
    end
  end

  describe 'GET /users/:id' do
    it 'response status is correct' do
      user = User.create(name: 'John')
      get user_path(user)
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      user = User.create(name: 'John')
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it 'renders the correct content' do
      user = User.create(name: 'John')
      get user_path(user)
      expect(response.body).to include('John')
    end
  end
end
