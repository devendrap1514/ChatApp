class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receivable, polymorphic: true

  before_validation :check_self_message, if: -> { receivable.class.name == "User" }

  validates :content, presence: true

  private

  def check_self_message
    if sender.id == receivable.id
      errors.add(:base, "can't send message to self")
    end
  end
end
