class User < ApplicationRecord
  has_secure_password

  has_many :send_messages, class_name: "Message", foreign_key: "sender_id", dependent: :destroy
  has_many :received_messages, class_name: "Message", as: :receivable, dependent: :destroy

  has_many :created_groups, class_name: 'Group', foreign_key: 'creator_id', dependent: :destroy
  has_many :user_groups, class_name: 'UserGroup', foreign_key: 'user_id', dependent: :destroy
  has_many :groups, through: :user_groups

  before_validation lambda {
    self.email.strip!
    self.email.downcase!
  }, if: lambda { self.email.present? }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
end
