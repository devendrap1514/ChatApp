class MessagesController < AppController
  before_action :find_receiver, only: %i[index create]

  def index
    @pagy, @messages = pagy(@receiver.messages.order(created_at: :asc))
    render json: MessageSerializer.new(@messages)
  end

  def create
    @message = Message.new(create_params)
    if @message.save
      message_ser = MessageSerializer.new(@message)
      if @receiver.class.name == "Group"
        render json: message_ser
      else
        render json: { errors: ['Not Implement'] }, status: :bad_request
      end
    else
      flash.now[:notice] = @message.errors.full_messages
      render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def create_params
    params.permit(:sender_id, :receivable_type, :receivable_id, :content).merge(sender_id: current_user.id)
  end

  def find_receiver
    receivable_type = params[:receivable_type]
    receivable_type.constantize  # not check model in below line
    unless receivable_type.present? && ActiveRecord::Base.descendants.map(&:name).include?(receivable_type)
      raise TypeError
    end
    @receiver = receivable_type.constantize.find(params[:receivable_id])
  rescue TypeError
    render json: { errors: ['No such receiver type present'] }
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Receiver not found'] }
  end
end
