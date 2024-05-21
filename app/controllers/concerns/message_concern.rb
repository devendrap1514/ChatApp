module MessageConcern
  extend ActiveSupport::Concern

  def get_messages
    messages = Message.none
    if @receiver.class.name == "User"
      messages = messages.or(current_user.send_messages.where(receivable_type: @receiver.class.name, receivable_id: @receiver.id))
      messages = messages.or(current_user.received_messages.where(sender_id: @receiver.id))
    elsif @receiver.class.name == "Group"
      messages = @receiver.messages
    else
      raise UnknownType
    end
    messages
  end
end
