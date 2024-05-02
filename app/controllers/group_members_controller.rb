class GroupMembersController < ApplicationController
  before_action :find_group, only: %i[create]
  def create
    unless User.find_by(id: params[:member_id])
      return respond_to do |format|
        format.json { render json: { errors: ['User not found'] }, status: :not_found }
        format.html {  }
      end
    end
    @group.user_groups.create(user_id: params[:member_id])
    respond_to do |format|
        format.json { render json: { errors: ['Successfully added'] }, status: :ok }
        format.html {  }
      end
  end

  private

  def find_group
    @group = @current_user.groups.find(params[:group_id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.json { render json: { errors: ['Group not found'] }, status: :not_found }
      format.html {  }
    end
  end
end
