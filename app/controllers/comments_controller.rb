# frozen_string_literal: true

# Class to deal with the comments entity
class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @blogger = User.find(@article[:user_id]).followers
    @comments = @article.comments.create(comment_params) if user_signed_in? && @blogger.include?(current_user)
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
