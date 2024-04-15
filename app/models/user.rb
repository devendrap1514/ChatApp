class User < ApplicationRecord
  has_secure_password

  has_many :send_messages, class_name: "Message", foreign_key: "sender_id", dependent: :destroy
  has_many :received_messages, class_name: "Message",  foreign_key: "receiver_id", dependent: :destroy

  before_validation lambda {
    self.email.strip!
    self.email.downcase!
  }, if: lambda { self.email.present? }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
end
