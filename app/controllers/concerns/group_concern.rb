module GroupConcern
  extend ActiveSupport::Concern

  def get_groups
    current_user.groups
  end
end
