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
  
  #select for download
  def download 
    render json: Post.all 
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

  def upload
    file = params[:csvfile]
    @err = ""
    @validateErr = []
    @postList =[]
    if file.content_type == "application/vnd.ms-excel"
      CSV.foreach(file.path, headers: true) do |row|
        if(row.count == 3)
          break @err="Wrong CSV File header " if row.headers[0]!="title" || row.headers[1] != "description" || row.headers[2] != "status"
        else
          break @err="Post Upload CSV must have 3 columns"
        end
        #If the ID is found, call the record, if not found, create a new one
        # @post = Post.find_by(title: row["title"]) || Post.new
        @post = Post.new(row.to_hash.slice(*updatable_attributes))
        @post[:create_user_id] = params[:create_user_id]
        @post[:updated_user_id] = params[:updated_user_id]
        break @err=@post.errors if !@post.valid?
        #Get data from CSV and set     
        # @post = row.to_hash.slice(*updatable_attributes)
        @postList << @post
        #save
      end
    else
      @err = "Please Choose CSV file Format"
    end
    
    if(@err != "")
      render json: @err , status: 400
    else
      @postList.each do |value|
        newPost = Post.new
        newPost.title = value.title
        newPost.description = value.description
        newPost.status = value.status
        newPost.create_user_id = value.create_user_id
        newPost.updated_user_id = value.updated_user_id
        newPost.save
      end  
      render json: {response: "ok"}
    end
  end
  
  def updatable_attributes
    ["title", "description", "status"]
  end

  private
  def post_params
    params.require(:post).permit(:title, :description, :status, :create_user_id, :updated_user_id, :deleted_user_id, :deleted_at)
  end  
  

end
