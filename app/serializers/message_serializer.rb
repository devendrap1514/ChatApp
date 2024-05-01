class MessageSerializer < ApplicationSerializer
  attributes :id, :receiver, :content

  attribute :sender do |object|
    UserSerializer.new(object.sender)
    object.sender.email
  end

  attribute :receiver do |object|
    object.receivable
  end
end
