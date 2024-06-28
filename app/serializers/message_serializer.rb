class MessageSerializer < ApplicationSerializer
  attributes :id, :receiver, :content, :created_at

  attribute :sender do |object|
    object.sender.email
  end

  attribute :receiver do |object|
    object.receivable.name
  end
end
