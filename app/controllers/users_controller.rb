class UsersController < ApplicationController
  before_action :authorized, only: [:auto_login , :create, :validate , :index]

  def index
    @users = User.where(deleted_user_id: nil)
    @userInfo = []
    @users.each do |user|
      # profile image 
      if(user.profile)
        filename = user.profile
        path = "app/assets/images/"+filename
        data = File.open(path, 'rb') {|file| file.read }
        imgfile = "data:image;base64,#{Base64.encode64(data)}"
        user.profile = imgfile
      end
      user_info = user.attributes
      createdUser = User.find(user.create_user_id)
      updatedUser = User.find(user.updated_user_id)
      user_info[:createdUser] = createdUser.name
      user_info[:updatedUser] = updatedUser.name
      @userInfo << user_info  
    end
    render json: @userInfo
  end

  #VALIDATE 
  def validate
    @user = User.new(user_params)
    if !@user.valid?        
      render json: @user.errors , status: 400
    else 
      render  json: @user, status: 200 
    end
  end

  # REGISTER
  def create
    if(params[:image])
      imgname = params[:image].original_filename
      username = params[:name]
      path = File.join("app", "assets" , "images" ,(username+imgname))
      File.open(path, "wb") { |f| f.write(params[:image].read) }
    end
    @user = User.new(user_params)
    if @user.save
      render json: {"response":"ok"}, status: 200
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  #DETAILS
  def details
    user = User.find(params[:id])
    if(user.profile)
      filename = user.profile
      path = "app/assets/images/"+filename
      data = File.open(path, 'rb') {|file| file.read }
      imgfile = "data:image;base64,#{Base64.encode64(data)}"
      user.profile = imgfile
    end
    render json: user
  end

  #UPDATE for Soft delete and edit function 
  def update
    @user = User.find_by(id: params[:id])
    aa = @user.update(user_params)
    if(aa)
      render json: {"response":"ok"} 
    else
      render json: {"response":"update fail"}, status: :unprocessable_entity
    end
  end

   # LOGGING IN
   def login
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {error: "Invalid email or password"} , status: 401
    end
  end

  def auto_login
    render json: @user
  end

  private
  
    def user_params
      params.permit(:name, :email, :password, :profile , :role, :phone, :address, :dob, :create_user_id, :updated_user_id, :deleted_user_id,:deleted_at)
    end 
end