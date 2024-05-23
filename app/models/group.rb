class Group < ApplicationRecord

  # Associations
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  has_many :messages, class_name: "Message", as: :receivable, dependent: :destroy
  has_many :memberships
  has_many :users, through: :memberships

  # Validations
  validates :name, presence: true

  # Callbacks
  after_create :assign_as_a_member

  private
  def assign_as_a_member
    users << creator
  end
end
