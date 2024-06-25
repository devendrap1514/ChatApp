class AppController < ActionController::Base
  include ParamChecker
  protect_from_forgery with: :null_session

  before_action :authorize_request

  def authorize_request
    token = request.headers[:token] || params[:token] || session[:token]
    decode_hash = JsonWebToken.decode(token)
    id = decode_hash[:id]
    @current_user = User.find(id)
  rescue ActiveRecord::RecordNotFound
    format.json { render json: { error: "User not found" }, status: :not_found }
    format.html { redirect_to login_form_session_path, notice: 'User not found' }
  rescue JWT::DecodeError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :unauthorized }
      format.html { redirect_to login_form_session_path }
    end
  end

  def current_user
    @current_user || nil
  end
end
