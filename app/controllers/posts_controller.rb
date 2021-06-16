class PostsController < ApplicationController
  include Paginable
  before_action :authorize_request_admin, except: [:index, :show]

  #Inclui o conteúdo e a image de banner nas postagens com paginação
  def index
    posts = Post.page(current_page).per(per_page).map do |post|
      content = post.content.body.to_html
      url = url_for(post.banner_image)
      post.attributes.merge(content: content, banner_image: url)
    end
    render json: posts, status: :ok
  end
  
  #Inclui o conteúdo e a image de banner na postagem
  def show
    post = Post.find(params[:id])
    content = post.content.body.to_html
    url = url_for(post.banner_image)
    render json: post.attributes.merge(content: content, banner_image: url), status: :ok
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