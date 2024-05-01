class Group < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  has_many :messages, class_name: "Message", as: :receivable, dependent: :destroy

  has_many :user_groups, class_name: 'UserGroup', foreign_key: 'group_id', dependent: :destroy
  has_many :users, through: :user_groups

  validates :name, presence: true

  after_create :assign_as_a_member

  private
  def assign_as_a_member
    UserGroup.create(user: creator, group: self)
  end
end
