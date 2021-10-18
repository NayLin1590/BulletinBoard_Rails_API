class PostsController < ApplicationController
  before_action :authorized, except: [:index ]

  def index
    @posts = Post.all
    @info =[]
    @posts.each do |post|
      user_info = post.attributes
      user_info[:create_user] = post.create_user
      user_info[:updated_user] = post.updated_user
      @info << user_info
    end
    # render json: {post: @posts, create_user: @posts.create_user , updated_user: @posts.updated_user}
    render json: @info
  end
  
  def create
    @user = User.find_by(id: 9)
    @post = @user.post_params.create(title:"Test1",description:"testing",status: 1,create_user_id: 4,updated_user_id: 4)
    # @post = Post.new(post_params)
    if(@post.save)
      render json: @post
    else
      render json: @post.errors
    end
  end

  def details
    @post = Post.find_by(id: 1)
    render json: @post.updated_user.name
  end

  private
  def post_params
    params.require(:post).permit(:title, :description,:status, :create_user_id, :updated_user_id)
  end  
  

end
