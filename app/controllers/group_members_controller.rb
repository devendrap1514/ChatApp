class GroupMembersController < ApplicationController
  before_action :find_group, only: %i[index create]

  def index
    @members = @group.users
    render json: UserSerializer.new(@members)
  end

  def create
    unless User.find_by(id: params[:member_id])
      return render json: { errors: ['User not found'] }, status: :not_found
    end
    @group.user_groups.create(user_id: params[:member_id])
    render json: { errors: ['Successfully added'] }, status: :ok
  end

  private

  def find_group
    @group = @current_user.groups.find(params[:group_id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Group not found'] }, status: :not_found
  end
end
