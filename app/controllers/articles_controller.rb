# frozen_string_literal: true

# Class to deal with the articles entity
class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  # READ
  def show
    @article = Article.find(params[:id])
  end

  # CREATE
  def new
    if user_signed_in?
      @article = Article.new
    else
      redirect_to root_path
    end
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  # UPDATE
  def edit
    @article = Article.find(params[:id])
    redirect_to @article unless user_signed_in? && current_user[:id] == @article.user_id
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  # DELETE
  def destroy
    @article = Article.find(params[:id])
    if user_signed_in? && current_user[:id] == @article.user_id
      @article.destroy
      redirect_to root_path
    else
      redirect_to @article
    end
  end

  private

  def article_params
    form = params[:article].merge({ user_id: current_user[:id] })
    form.permit(:title, :body, :status, :user_id)
  end
end
