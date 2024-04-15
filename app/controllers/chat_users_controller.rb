class ChatUsersController < ApplicationController

  def index
    @users = User.joins(:send_messages).where("messages.sender_id = :sender_id OR messages.receiver_id = :receiver_id", sender_id: current_user.id, receiver_id: current_user.id)
    render json: UserSerializer.new(@users.uniq)
  end
end
