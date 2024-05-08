class ChatUsersController < ApplicationController
  include UserAndGroup

  def index
    @chat_users = get_chat_users
    render json: UserSerializer.new(@chat_users)
  end

  def search
    @users = User.where('email ILIKE ?', "%#{params[:query]}%").limit(10)
    render json: UserSerializer.new(@users)
  end
end
