class PostsController < ApplicationController
  before_action :authorize_request_admin, except: [:index, :show]

  def index
    posts = Post.all
    render json: posts, status: :ok
  end
  
  def show
    post = Post.find(params[:id])
    render json: post, status: :ok
  end

  def create
    post = Post.new(title: params[:title], views: params[:views], banner_image: params[:banner_image], content: params[:content], tag_ids: params[:tag_ids])
    if post.save
      render json: post, status: :created
    else
      render json: { errors: post.errors.full_messages }, status: :bad_request
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
      render json: { errors: post.errors.full_messages }, status: :bad_request
    end
  end

  private
  def post_params
    params.permit(:title, :views, :banner_image, :content, :tag_ids)
  end
end