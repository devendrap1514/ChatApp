class MessagesController < ApplicationController
  include MessageConcern
  include GroupConcern
  include UserConcern

  before_action :find_receiver, only: %i[index create]
  before_action :find_group, only: %i[index]

  def index
    @messages = get_messages
    render json: MessageSerializer.new(@messages)
  end

  def create
    @message = Message.new(create_params)
    if @message.save
      if @receiver.class.name == "User"
        # UsersChannel.broadcast_to("users", ChatUserSerializer.new(get_chat_users))
      elsif @receiver.class.name == "Group"
        # GroupsChannel.broadcast_to("groups", GroupSerializer.new(get_groups))
      else
        raise UnknownType
      end
      render json: MessageSerializer.new(@message)
    else
      render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def create_params
    params.permit(:sender_id, :receivable_type, :receivable_id, :content).merge(sender_id: current_user.id)
  end

  def find_receiver
    is_params_present, output = is_params_present?([:receivable_type, :receivable_id])
    unless is_params_present
      return render json: { errors: 0 }, status: :bad_request
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

  def find_group
    @group = @current_user.groups.find(params[:receivable_id]) if @receiver.class.name == "Group"
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Group not found'] }, status: :not_found
  end
end
