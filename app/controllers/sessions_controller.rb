class SessionsController < ApplicationController
  before_action :authorize_request, only: %i[]

  def new

  end

  def login
    is_params_present, output = is_params_present?([:email, :password])
    unless is_params_present
      return render json: { errors: output }, status: :bad_request
    end
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = JsonWebToken.encode(id: user.id)
      session[:token] = token
      return respond_to do |format|
        format.json { render json: UserSerializer.new(user, meta: { token: token }) }
        format.html { redirect_to root_path }
      end
    else
      return render json: { errors: ['Invalid username or passord'] }, status: :bad_request
    end
  end

  def logout
    session.delete(:token)
  end
end
