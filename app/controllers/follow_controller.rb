# frozen_string_literal: true

# Class to deal with the follow relation
class FollowController < ApplicationController
  def create
    @article = Article.find(params[:article])
    @follower = User.find(current_user[:id])
    @followee = User.find(@article[:user_id])
    @follow = Follow.new(follower: @follower, followee: @followee)
    @follow.save
    redirect_to article_path(@article)
  end
end
