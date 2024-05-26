class HomesController < ApplicationController
  include MessageConcern
  include GroupConcern
  include UserConcern

  def index
    @groups = get_groups
    @users = get_chat_users
  end
end
