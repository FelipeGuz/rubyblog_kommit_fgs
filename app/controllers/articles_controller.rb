# frozen_string_literal: true

# Class to deal with the articles entity
class ArticlesController < ApplicationController
  # Security authentication
  http_basic_authenticate_with name: 'dhh',
                               password: 'secret',
                               except: %i[index show]

  def index
    @articles = Article.all
  end

  # READ
  def show
    puts "This are my parameters: #{params}"
    @article = Article.find(params[:id])
  end

  # CREATE
  def new
    @article = Article.new
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
    puts "This are my parameters (DELETE): #{params}"
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path
  end

  private

  def article_params
    puts "This are my parameters: #{params}"
    params.require(:article).permit(:title, :body, :status)
  end
end
