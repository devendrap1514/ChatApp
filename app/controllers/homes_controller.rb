class HomesController < ApplicationController
  def index
    @chat_users = []
    current_user.send_messages.where(receivable_type: "User").select(:receivable_id, :receivable_type).group(:receivable_id, :receivable_type).each do |message|
      @chat_users << message.receivable
    end

    current_user.received_messages.select(:sender_id).group(:sender_id).each do |message|
      @chat_users << message.sender
    end

    @chat_users = @chat_users.uniq
    @groups = @current_user.groups

    respond_to do |format|
      format.json { render json: UserSerializer.new(@chat_users) }
      format.html {}
    end
  end
end
