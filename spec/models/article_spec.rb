require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'article score' do
    let(:comment) { instance_double(Comment, score: 0) }

    it 'should call comments atribute' do
      expect(subject).to receive(:comments) { [comment] }.at_least(1).times
      subject.score
    end

    it 'is not nan when has comments' do
      allow(subject).to receive(:comments) { [comment] * 3 }
      expect(subject.score).not_to be_nil
    end

    it 'is not nan when it doesn\'t have comments' do
      expect(subject.score).not_to be_nil
    end

    it 'should calculate the comments score' do
      comment1 = instance_double(Comment, score: 1)
      comment2 = instance_double(Comment, score: 2)
      comment3 = instance_double(Comment, score: 3)

      allow(subject).to receive(:comments) { [comment1, comment2, comment3] }
      expect(subject.score).to eql(2.0)
    end
  end
end

RSpec.describe 'Articles Relations', type: :request do
  let(:article) { { title: 'new article', body: 'article for testing!!', status: 'public' } }

  describe 'with comments' do
    it 'should delete all the comments realted to the article' do
      blogger = User.new(email: 'blogger@mail.com', password: 'secret', password_confirmation: 'secret')
      follower = User.new(email: 'follower@mail.com', password: 'secret', password_confirmation: 'secret')

      # Registration
      blogger.save
      follower.save

      # Creating article
      sign_in User.all[-2]
      post articles_path(article: article)
      sign_out User.all[-2]

      # Follower sign in, follow the blogger and comment
      sign_in User.last

      post follow_index_path(article: Article.last)

      comment = { commenter: User.last[:email], body: 'simple comment', status: 'public', score: 5 }
      post article_comments_path(Article.last[:id], comment: comment)

      sign_out User.last

      # Blogger sign in and delete article
      sign_in User.all[-2]
      new_article = Article.last
      new_comment = Comment.last
      delete article_path(id: new_article[:id])

      # Expecting comment was deleted too
      expect(Article.all).not_to include(new_article)
      expect(Comment.all).not_to include(new_comment)
    end
  end
end
