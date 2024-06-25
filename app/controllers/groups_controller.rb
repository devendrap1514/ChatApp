class GroupsController < AppController
  include GroupConcern

  before_action :find_group, only: %i[show]

  def index
    @groups = get_groups
    respond_to do |format|
      format.json { render json: GroupSerializer.new(@groups) }
      format.html {  }
    end
  end

  def show
    @messages = @group.messages
    respond_to do |format|
      format.json {  }
      format.html {  }
    end
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
