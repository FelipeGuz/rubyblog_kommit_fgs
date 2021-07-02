# frozen_string_literal: true

# Class to deal with the comments entity
class CommentsController < ApplicationController
  # security authentication
  http_basic_authenticate_with name: 'dhh', password: 'secret', only: :destroy

  def create
    @article = Article.find(params[:article_id])
    @comments = @article.comments.create(comment_params) if user_signed_in?
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body, :status, :score)
  end
end
