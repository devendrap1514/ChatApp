class MessagesController < ApplicationController
  before_action :find_receiver, only: %i[index create]

  def index
    if @receiver.class.name == "User"
      @messages = Message.none
      @messages = @messages.or(current_user.send_messages.where(receivable_type: @receiver.class.name, receivable_id: @receiver.id))
      @messages = @messages.or(current_user.received_messages.where(sender_id: @receiver.id))
    elsif @receiver.class.name == "Group"
      @messages = @receiver.messages
    end
  end

  def create
    message = Message.new(create_params)
    if message.save
      # UserChannel.broadcast_to(@receiver, MessageSerializer.new(message))
      render json: MessageSerializer.new(message)
    else
      render json: { errors: message.errors.full_messages }
    end
  end

  private
  def create_params
    params.permit(:sender_id, :receivable_type, :receivable_id, :content).merge(sender_id: current_user.id)
  end

  def find_receiver
    is_params_present, output = is_params_present?([:receivable_type, :receivable_id])
    unless is_params_present
      return respond_to do |format|
        format.json {
          render json: { errors: op }, status: :bad_request
        }
        format.html {
          flash.alert = op
          redirect_to :root_path
        }
      end
    end
    class_name = params[:receivable_type]
    class_name.constantize  # not check model in below line
    unless class_name.present? && ActiveRecord::Base.descendants.map(&:name).include?(class_name)
      raise TypeError
    end
    @receiver = class_name.constantize.find(params[:receivable_id])
  rescue TypeError
    render json: { errors: ['No such receiver type present'] }
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Receiver not found'] }
  end
end
