class ChatUserSerializer < ApplicationSerializer
  attributes :id, :name, :email

  attribute :last_message do |object|
    byebug
    "last_message"
  end
end
