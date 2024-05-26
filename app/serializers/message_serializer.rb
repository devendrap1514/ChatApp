class MessageSerializer < ApplicationSerializer
  attributes :id, :receiver, :content

  attribute :sender do |object|
    object.sender.email
  end

  attribute :receiver do |object|
    GroupSerializer.new(object.receivable) if object.receivable.class.name == 'Group'
    UserSerializer.new(object.receivable) if object.receivable.class.name == 'User'
  end
end
