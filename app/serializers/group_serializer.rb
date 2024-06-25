class GroupSerializer < ApplicationSerializer
  attributes :id, :name

  attribute :last_message do |object, params|
    object.messages.last&.content
  end
end
