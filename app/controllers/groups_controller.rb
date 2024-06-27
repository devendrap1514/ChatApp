class GroupsController < AppController
  before_action :find_group, only: %i[show]

  def index
    @pagy, @groups = pagy(@current_user.groups)
    render_ok_response(GroupSerializer.new(@groups), pagination: @pagy)
  end

  def show
    render json: GroupSerializer.new(@group)
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

    def find_group
      @group = @current_user.groups.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: ['Group not found'] }, status: :not_found
    end
end
