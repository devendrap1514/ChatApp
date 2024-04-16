class ChatUsersController < ApplicationController

  def index
    chat_users = []
    current_user.send_messages.select(:receiver_id).group(:receiver_id).each do |message|
      chat_users << message.receiver
    end

    current_user.received_messages.select(:sender_id).group(:sender_id).each do |message|
      chat_users << message.sender
    end

    render json: UserSerializer.new(chat_users.uniq)
  end
end
