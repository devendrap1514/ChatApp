class AppController < ActionController::Base
  include RenderResponse
  include JsonWebTokenValidation
  include Pagy::Backend

  rescue_from RequestParamsValidation::RequestParamError do |e|
    render_bad_request_response([e.message], message: "Contact with api creator for more info")
  end

  protect_from_forgery with: :null_session

  before_action :validate_token!
  before_action :validate_params!

  def current_user
    @current_user || nil
  end
end
