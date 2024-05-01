class SessionsController < ApplicationController
  before_action :authorize_request, only: %i[]

  def login_form
  end

  def login
    is_params_present, op = is_params_present?([:email, :password])
    unless is_params_present
      return respond_to do |format|
        format.json {
          render json: { errors: op }, status: :bad_request
        }
        format.html {
          flash.alert = op
          render :login_form, status: :bad_request
        }
      end
    end
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      return respond_to do |format|
        token = JsonWebToken.encode(id: user.id)
        format.json {
          render json: UserSerializer.new(user, meta: { token: token })
        }
        format.html {
          flash.alert = ['Successfully Login']
          session[:token] = token
          redirect_to root_path
        }
      end
    else
      return respond_to do |format|
        format.json {
          render json: { errors: ['Invalid username or passord'] }, status: :bad_request
        }
        format.html {
          flash.alert = ['Invalid username or passord']
          render :login_form, status: :bad_request
        }
      end
    end
  end

  def logout
    session.delete(:token)
    respond_to do |format|
      format.json { render json: { message: "Successfully Logout" }, status: :ok }
      format.html { redirect_to root_path }
    end

  end
end
