class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receivable, polymorphic: true

  before_validation :check_self_message, if: -> { receivable.class.name == "User" }

  validates :content, presence: true

  before_save :check_group_member, if: -> { receivable.class.name == "Group" }

  private

  def check_self_message
    if sender.id == receivable.id
      errors.add(:base, "can't send message to self")
    end
  end

  def check_group_member
    unless receivable.users.include?(sender)
      errors.add(:sender, "not a member of this group")
    end
  end
end
