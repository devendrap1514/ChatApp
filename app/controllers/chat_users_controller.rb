class ChatUsersController < ApplicationController
  include UserConcern

  def index
    @chat_users = get_chat_users
    render json: ChatUserSerializer.new(@chat_users)
  end

  def search
    @users = User.where('email ILIKE ?', "%#{params[:query]}%").limit(10)
    render json: UserSerializer.new(@users)
  end
end
