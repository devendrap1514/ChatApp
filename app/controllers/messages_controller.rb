class MessagesController < ApplicationController
  include Pagy::Backend

  before_action :find_user, only: %i[index]
  before_action :find_receiver, only: %i[create]

  def index
    messages = current_user.send_messages.where(receiver_id: @user.id)
    render json: MessageSerializer.new(messages)
  end

  def create
    message = Message.new(create_params)
    if message.save
      UserChannel.broadcast_to(current_user, MessageSerializer.new(message))
      render json: MessageSerializer.new(message)
    else
      render json: { errors: message.errors.full_messages }
    end
  end

  private
  def create_params
    params.permit(:sender_id, :receiver_id, :content).merge(sender_id: current_user.id)
  end

  def find_receiver
    @sender = User.find(params[:receiver_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }
  end

  def find_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }
  end
end
