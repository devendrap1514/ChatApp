class SessionsController < ApplicationController
  before_action :authorize_request, only: %i[]

  def login
    is_params_present, op = is_params_present?([:email, :password])
    unless is_params_present
      return render json: { errors: op }, status: :bad_request
    end
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: UserSerializer.new(user, meta: { token: JsonWebToken.encode(id: user.id) })
    else
      render json: { error: 'Invalid username or passord' }
    end
  end
end
