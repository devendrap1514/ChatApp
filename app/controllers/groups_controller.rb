class GroupsController < ApplicationController
  before_action :authorize_request, only: %i[index create]

  def index
    @groups = @current_user.groups
  end

  def create
    group = Group.new(group_create_params)
    if group.save
      render json: GroupSerializer.new(group)
    else
      render json: { errors: group.errors.full_messages }
    end
  end

  private
  def group_create_params
    params.permit(:name)
  end
end
