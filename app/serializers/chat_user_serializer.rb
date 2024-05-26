class ChatUserSerializer < ApplicationSerializer
  attributes :id, :name, :email

  attribute :last_message do |object|
    MessageSerializer.new(object.send_messages.limit(1).or(object.received_messages.limit(1)).order(created_at: :desc).last)
  end
end
