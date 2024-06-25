class SessionsController < AppController
  before_action :authorize_request, only: %i[]

  require_params_for(:login, :email, :password)

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = JsonWebToken.encode(id: user.id)
      return respond_to do |format|
        format.json { render json: UserSerializer.new(user, meta: { token: token }) }
        format.html {
          session[:token] = token
          redirect_to root_path
        }
      end
    else
      return render json: { errors: ['Invalid email or passord'] }, status: :bad_request
    end
  end

  def logout
    session.delete(:token)
    redirect_to root_path
  end
end
