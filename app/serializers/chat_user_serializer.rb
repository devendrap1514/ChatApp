class ChatUserSerializer < ApplicationSerializer
  attributes :id, :name, :email

  attribute :last_message do |object|
    object.send_messages.limit(1).or(object.received_messages.limit(1)).order(created_at: :desc).last&.content
  end
end
