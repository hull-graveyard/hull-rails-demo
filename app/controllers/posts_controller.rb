class PostsController < ApplicationController
  
  before_filter :authenticate_user!

  def index
    @posts = Post.where({}).reverse_order
  end

  def create
    post = current_user.posts.create(params[:post])
    redirect_to '/posts'
  end

end
