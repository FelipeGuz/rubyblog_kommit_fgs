require 'rails_helper'

# test for the rading operations
RSpec.describe 'ArticleController Reading', type: :request do
  describe 'GET index' do
    it 'should return all the articles' do
      get root_path
      expect(response).to be_successful
    end
  end

  describe 'GET show' do
    it 'should return the article object with the indicated id' do
      get article_path(id: 1)
      expect(response).to be_successful
    end
  end
end

# test for the create operations
RSpec.describe 'ArticleController Create', type: :request do
  before do
    user = User.new(id: 1, email: 'user@mail.com', password: 'secret', password_confirmation: 'secret')
    sign_in user
  end

  describe 'GET new' do
    it 'should create a "new" Article object if user is signed in' do
      get new_article_path
      expect(response).to be_successful
    end
  end

  describe 'POST create' do
    it 'should create a new article' do
      article = { title: 'test', body: 'this is a article bulding test', status: 'public' }
      post articles_path(article: article)
      expect(response).to redirect_to(article_path(id: Article.last[:id]))
      expect(Article.last.title).to eq(article[:title])
      expect(Article.last.body).to eq(article[:body])
    end
  end
end

# test for the update operations
RSpec.describe 'ArticleController Update', type: :request do
  let(:article) { Article.last }
  before do
    user = User.new(id: 1, email: 'user@mail.com', password: 'secret', password_confirmation: 'secret')
    sign_in user
  end

  describe 'GET edit' do
    it 'should creat a edit environment' do
      get edit_article_path(article[:id])
      expect(response).to be_successful
    end
  end

  describe 'POST update' do
    it 'should update the selected article' do
      article[:title] += '2'
      article[:body] += '2'
      put article_path(id: article[:id], article: {title: article[:title], body: article[:body]})
      expect(response).to redirect_to(article_path(id: article[:id]))
      expect(Article.last.title).to eq(article[:title])
      expect(Article.last.body).to eq(article[:body])
    end
  end
end

# test for the delete operations
RSpec.describe 'ArticleController Delete', type: :request do
  let(:article) { Article.last }

  before do
    user = User.new(id: 1, email: 'user@mail.com', password: 'secret', password_confirmation: 'secret')
    sign_in user
  end

  describe 'DELETE delete' do
    it 'should delete an article' do
      delete article_path(id: article[:id])
      expect(Article.all).not_to include(article)
      expect(response).to redirect_to(root_path)
    end
  end
end
