# This class is responsible to manage post CRUD operation
class PostsController < ApplicationController
  before_action :authorize_request, only: %i[]

  def index
    render json: PostSerializer.new(Post.all)
  end

  def create
    post = Post.new(create_params)
    if post.save
      render json: { message: "Good" }
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.permit(:video)
  end
end
