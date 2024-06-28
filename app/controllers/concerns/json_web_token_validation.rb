module JsonWebTokenValidation
  extend ActiveSupport::Concern

  included do
    before_action :validate_token!
  end

  def validate_token!
    token = request.headers[:token] || params[:token]
    decode_hash = JsonWebToken.decode(token)
    @id = decode_hash[:id]
    @current_user = User.find(@id)
    # set_timezone

  rescue ActiveRecord::RecordNotFound
    render_not_found_response(["User not found"])
  rescue JWT::ExpiredSignature
    render_unprocessable_response(["Token is expired"])
  rescue JWT::DecodeError => e
    render_unauthorized_response(["Token decode error"])
  end

  def set_timezone(timezone='UTC')
    Time.zone = @current_user&.timezone || timezone
  end

  def current_user
    @current_usee
  end
end
