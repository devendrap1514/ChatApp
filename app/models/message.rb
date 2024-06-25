class Message < ApplicationRecord

  # Associations
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receivable, polymorphic: true

  # Callbacks
  before_validation :check_self_message, if: -> { receivable.class.name == "User" }
  before_validation :check_group_member, if: -> { receivable.class.name == "Group" }
  after_create :braodcast_message_to_group, if: -> { receivable.class.name == "Group" }

  # Validations
  validates :content, presence: true

  private

  def check_self_message
      errors.add(:base, "not implement person chat")
  end

  def check_group_member
    unless receivable.users.include?(sender)
      errors.add(:sender, "not a member of this group")
    end
  end

  def braodcast_message_to_group
    GroupChannel.broadcast_to(receivable, MessageSerializer.new(self))
  end
end
