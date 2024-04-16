class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'

  before_validation :check_self_message

  # default_scope { order(:created_at) }

  private

  def check_self_message
    if sender.id == receiver.id
      errors.add(:base, "can't send message to self")
    end
  end
end
