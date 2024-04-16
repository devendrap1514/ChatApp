class MessagesController < ApplicationController
  include Pagy::Backend

  before_action :find_chat_person, only: %i[index]
  before_action :find_receiver, only: %i[create]

  def index
    # me => receiver
    # receiver => me
    # all messages that we send each other
    messages = Message.none
    messages = messages.or(current_user.send_messages.where(receiver_id: @chat_person.id))
    messages = messages.or(current_user.received_messages.where(sender_id: @chat_person.id))
    render json: MessageSerializer.new(messages.order(:created_at))
  end

  def create
    message = Message.new(create_params)
    if message.save
      UserChannel.broadcast_to(@receiver, MessageSerializer.new(message))
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
    @receiver = User.find(params[:receiver_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }
  end

  def find_chat_person
    @chat_person = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }
  end
end
