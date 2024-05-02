class ChatUsersController < ApplicationController
  include UserAndGroup

  def index
    @chat_users = get_chat_users
    respond_to do |format|
      format.json { render json: UserSerializer.new(@chat_users)}
      format.html {}
    end
  end

  def search
    @users = User.where('email ILIKE ?', "%#{params[:query]}%").limit(10)
    respond_to do |format|
      format.json { render json: UserSerializer.new(@users) }
      format.html
    end
  end
end
