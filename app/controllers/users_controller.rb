class UsersController < ApplicationController
  before_action :authorize_request, except: [:create]

  def index
    users = User.all
    render json: users, status: :ok
  end
  
  def find
    user = User.find(params[:id])
    render json: user, status: :ok
  end

  def create
    user = User.new(name: params[:name], email: params[:email], password: params[:password], photo: params[:photo])
    if user.save
      render json: user, status: :created
    else
      render status: :bad_request
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render status: :ok
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user, status: :ok
    else
      render status: :bad_request
    end
  end

  private
  def find_user
    user = User.find_by_email!(params[:email])
    if !user
      render status: :not_found
    end
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :photo)
  end    
end