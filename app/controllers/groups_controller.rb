class GroupsController < ApplicationController
  include UserAndGroup

  def index
    @groups = get_groups
    respond_to do |format|
      format.json { render json: GroupSerializer.new(@groups)}
      format.html {}
    end
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
