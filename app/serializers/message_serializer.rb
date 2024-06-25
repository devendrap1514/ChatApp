class MessageSerializer < ApplicationSerializer
  attributes :id, :receiver, :content

  attribute :sender do |object|
    object.sender.email
  end

  attribute :receiver do |object|
    object.receivable.name
  end
end
