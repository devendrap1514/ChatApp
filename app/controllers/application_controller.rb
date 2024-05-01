class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :authorize_request

  def authorize_request
    token = request.headers[:token] || params[:token] || session[:token]
    decode_hash = JsonWebToken.decode(token)
    id = decode_hash[:id]
    @current_user = User.find(id)
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.json { render json: { error: "User not found" }, status: :not_found }
      format.html { redirect_to login_form_session_path }
    end
  rescue JWT::DecodeError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :unauthorized }
      format.html { redirect_to login_form_session_path }
    end
  end

  def current_user
    @current_user || nil
  end

  def is_params_present?(keys)
    errors = []
    keys.each do |key|
      unless params[key].present?
        errors << "#{key} should be present"
      end
    end
    return [false, errors] unless errors.empty?
    return [true, errors]
  end
end
