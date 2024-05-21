class GroupsController < ApplicationController
  include GroupConcern

  def index
    @groups = get_groups
    render json: GroupSerializer.new(@groups)
  end

  def create
    group = @current_user.created_groups.new(group_create_params)
    if group.save
      render json: GroupSerializer.new(group)
    else
      render json: { errors: group.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def group_create_params
    params.permit(:name)
  end
end
