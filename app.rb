require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' #database config
require './models/post'         #Post class

get "/" do
  @posts = Post.order("created_at DESC")
  @title = "Welcome."
  erb :"posts/index"
end

get "/posts/create" do
  @title = "Create post"
  @post = Post.new
  erb :"posts/create"
end

post "/posts" do
  @post = Post.new(params[:post])
  if @post.save
    redirect "posts/#{@post.id}"
  else
    erb :"posts/create"
  end
end

get "/posts/:id" do
  @post = Post.find(params[:id])
  @title = @post.title
  erb :"posts/show"
end

helpers do
  def title
    if @title
      "#{@title}"
    else
      "Welcome."
    end
  end
end