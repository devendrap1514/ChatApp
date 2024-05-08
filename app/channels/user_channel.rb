class UserChannel < ApplicationCable::Channel
  def subscribed
    stream_for 'users'
  end

  def unsubscribed
  end
end
