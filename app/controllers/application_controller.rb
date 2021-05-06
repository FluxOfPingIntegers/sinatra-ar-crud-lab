
require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles' do
    @articles = Article.all

    erb :index
  end
  
  get '/articles/new' do

    erb :new
  end

  patch '/articles' do
    @article = Article.find(params[:id])
    @article.update(title: params[:title], content: params[:content])
    @article.save

    redirect "/articles/#{@article.id}"
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])

    erb :show
  end


  post '/articles/:id' do
    @article = Article.create({title: params[:title], content: params[:content]})


    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find(params[:id])

    erb :edit
  end

  delete '/articles/:id' do
    @article = Article.find(params[:id])
    @article.destroy
    @articles = Article.all

    erb :index
  end

end
