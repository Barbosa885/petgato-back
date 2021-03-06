class RepliesController < ApplicationController
  include Paginable
  before_action :set_reply, only: [:show, :update, :destroy]
  before_action :authorize_request, except: [:index, :show]
  before_action :authorize_request_admin, only: [:destroy]

  # GET /replies
  def index
    @replies = Reply.page(current_page).per(per_page)
    render json: @replies
  end

  # GET /replies/1
  def show
    render json: @reply
  end

  # POST /replies
  def create
    @reply = Reply.new(reply_params)

    if @reply.save
      render json: @reply, status: :created, location: @reply
    else
      render json: @reply.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /replies/1
  def update
    if @reply.update(reply_params)
      render json: @reply
    else
      render json: @reply.errors, status: :unprocessable_entity
    end
  end

  # DELETE /replies/1
  def destroy
    @reply.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reply
      @reply = Reply.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reply_params
      params.permit(:description, :comment_id, :user_id)
    end
end
