require 'rails_helper'

RSpec.describe 'ArticleController Reading' do
  subject { ArticlesController.new }

  before(:context) do
    @article = Article.new(title: 'test', body: 'test article', status: 'public', user_id: '1')
    @article.save
  end

  describe 'GET index' do
    it 'should return all the articles' do
      expect(subject.index).to eq(Article.all)
    end
  end

  describe 'GET show' do
    let(:params) { { id: 1 } }

    it 'should return the article object with the indicated id' do
      expect(subject).to receive(:params) { params }.exactly(1).times
      result = subject.show
      expect(result).to be_instance_of(Article)
      expect(result[:id]).to eq(1)
    end
  end
end

RSpec.describe 'ArticleController Create' do
  subject { ArticlesController.new }
  let(:article_params) { { title: 'test', body: 'test', status: 'test', user_id: '1' } }

  describe 'POST new/create' do
    it 'should create a "new" Article object if user is signed in' do
      expect(subject).to receive(:user_signed_in?) { true }
      expect(subject.new).to be_instance_of(Article)
    end

    it 'should return to new if the article was not created ' do
      allow(subject).to receive(:article_params) { article_params }
      expect_any_instance_of(Article).to receive(:save) { false }
      expect(subject).to receive(:render).with(:new) { :ok }
      subject.create
    end

    it 'should return to new if the article was not created ' do
      allow(subject).to receive(:article_params) { article_params }
      expect_any_instance_of(Article).to receive(:save) { true }
      expect(subject).to receive(:redirect_to).with be_instance_of(Article) { :ok }
      subject.create
    end
  end
end
