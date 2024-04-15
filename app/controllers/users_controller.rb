class UsersController < ApplicationController
  before_action :authorize_request, only: %i[destroy]

  def create
    user = User.new(create_params)
    if user.save
      render json: UserSerializer.new(user)
    else
      render json: { errors: user.errors.full_messages }
    end
  end

  def destroy
    current_user.destroy
    render json: { message: "User deleted successfully" }
  end

  private

  def create_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
