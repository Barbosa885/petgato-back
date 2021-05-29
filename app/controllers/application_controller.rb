class ApplicationController < ActionController::API
  def not_found
    render status: :not_found
  end
      
  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      decoded = JsonWebToken.decode(header)
      current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render status: :unauthorized
    rescue JWT::DecodeError => e
      render status: :unauthorized
    end
  end
end