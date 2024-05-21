module UserConcern
  extend ActiveSupport::Concern

  def get_chat_users
    chat_users = User.none

    current_user.send_messages.where(receivable_type: "User")
                .select(:receivable_id)
                .distinct
                .each do |message|
      chat_users = chat_users.or(User.where(id: message.receivable_id))
    end

    current_user.received_messages.select(:sender_id)
                .distinct
                .each do |message|
      chat_users = chat_users.or(User.where(id: message.sender_id))
    end

    chat_users
  end
end
