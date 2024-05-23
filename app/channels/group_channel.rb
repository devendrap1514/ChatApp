class GroupChannel < ApplicationCable::Channel
  def subscribed
    group = current_user.groups.find(params[:group_id])
    stream_for "groups-#{group}"
  rescue ActiveRecord::RecordNotFound
    reject "Group not found"
  end

  def unsubscribed
  end
end
