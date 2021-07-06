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

  def destroy
    @follow = Follow.where(follower_id: params[:follower], followee_id: params[:followee])
    @follow.destroy(@follow[0][:id]) if @follow && user_signed_in? && current_user[:id] == @follow[0][:follower_id]
    redirect_to current_user
  end
end
