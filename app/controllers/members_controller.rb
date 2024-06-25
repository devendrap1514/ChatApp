class MembersController < AppController
  before_action :find_group, only: %i[index create]

  def index
    @members = @group.users
    render json: UserSerializer.new(@members)
  end

  def create
    unless user = User.find_by(id: params[:member_id])
      return render json: { errors: ['User not found'] }, status: :not_found
    end
    membership = Membership.new(group: @group, user: user)
    if membership.save
      render json: { message: ['Successfully added'] }, status: :ok
    else
      render json: { errors: membership.errors.full_messages }
    end
  end

  private

  def find_group
    @group = @current_user.created_groups.find(params[:group_id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Group not found'] }, status: :not_found
  end
end
