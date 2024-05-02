class HomesController < ApplicationController
  include UserAndGroup

  def index
    @chat_users = get_chat_users
    @groups = get_groups
    respond_to do |format|
      format.json { render json: UserSerializer.new(@chat_users) }
      format.html {}
    end
  end
end
