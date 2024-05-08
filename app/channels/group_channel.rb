class GroupChannel < ApplicationCable::Channel
  def subscribed
    stream_for 'groups'
  end

  def unsubscribed
  end
end
