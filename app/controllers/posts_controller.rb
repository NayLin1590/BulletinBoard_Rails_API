class PostsController < ApplicationController
  before_action :authorized, except: [:index ]

  # select ALL
  def index
    @posts = Post.where(deleted_user_id: nil)
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

  #VALIDATE for Post Creation
  def validateCreate
    @post = Post.new(post_params)
    if !@post.valid?        
      render json: @post.errors , status: 422
    else 
      render  json: @post, status: 200 
    end
  end

   #VALIDATE for Post Update
  def validateEdit
    @post = Post.find_by(id: params[:id])
    @post.title = params[:post][:title]
    @post.description = params[:post][:description]
    if !@post.valid?        
      render json: @post.errors , status: 400
    else 
      render  json: @post, status: 200 
    end
  end

  # update (edit)
  def update
    @post = Post.find_by(id: params[:id])
    post = @post.update(post_params)
    if(post)
      render json: {"response":"ok"} 
    else
      render json: {"response":"update fail"},  status: :unprocessable_entity
    end     
  end

  # Create
  def create
    @post = Post.new(post_params)
    if @post.save
      render json: {"response":"ok"}, status: 200
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # soft delete
  def remove
    @post = Post.find_by(id: params[:id])
    post = @post.update(post_params)
    if(post)
      render json: {"response":"ok"} 
    else
      render json: {"response":"update fail"},  status: :unprocessable_entity
    end
  end

  # detail by id
  def details
    @post = Post.find_by(id: params[:id])
    render json: @post  
  end

  private
  def post_params
    params.require(:post).permit(:title, :description, :status, :create_user_id, :updated_user_id, :deleted_user_id, :deleted_at)
  end  
  

end
