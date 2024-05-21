class GroupSerializer < ApplicationSerializer
  attributes :id, :name

  attribute :last_message do |object, params|
    MessageSerializer.new(object.messages.last)
  end
end
