class GroupChannel < ApplicationCable::Channel
  def subscribed
    group = current_user.groups.find(params[:group_id])
    stream_for group
  rescue ActiveRecord::RecordNotFound
    puts("Group not found")
  end
end
