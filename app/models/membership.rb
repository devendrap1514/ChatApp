class Membership < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :group

  # Validations
  validates :user_id, uniqueness: { scope: :group_id, message: "is already a member of this group" }
end
