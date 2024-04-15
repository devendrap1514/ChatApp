class MessageSerializer < ApplicationSerializer
  attributes :id, :receiver, :content

  attribute :sender do |object|
    UserSerializer.new(object.sender)
  end

  attribute :receiver do |object|
    UserSerializer.new(object.receiver)
  end
end
