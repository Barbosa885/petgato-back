class PostsController < ApplicationController
  #has_many :comments
  #has_many :tagposts
  #has_many :likes

  def index
    posts = Post.all
    render json: posts, status: :ok
  end
  
  def show
    post = Post.find(params[:id])
    render json: post, status: :ok
  end

  def create
    post = Post.new(title: params[:title], views: params[:views], banner_image: params[:banner_image], content: params[:content])
    if post.save
      render json: post, status: :created
    else
      render status: :bad_request
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    render status: :ok
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      render json: post, status: :ok
    else
      render status: :bad_request
    end
  end

  private
  def find_post
    post = Post.find(params[:id])
    if !post
      render status: :not_found
    end
  end

  def post_params
    params.permit(:title, :views, :banner_image, :content)
  end
end