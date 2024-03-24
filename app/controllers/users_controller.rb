class UsersController < ApplicationController

  def index
    #flash.now[:alert] = "test"
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: "Successfully created User"
    else
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])

    if not @user.present?
      redirect_to users_path, notice: "User does not exist"
    end
  end

  def edit
    @user = User.find_by(id: params[:id])

    if not @user.present?
        redirect_to users_path, notice: "User does not exist"
    end
  end

  def update
    @user = User.find_by(id: params[:id])

    if not @user.present?
      redirect_to users_path, notice: "User does not exist"
    end

    @user.update(user_params)
    redirect_to users_path, notice: "Updated successfully"
  end

  private

  def user_params
    params.require("user").permit(:username, :email, :password, :password_confirmation, :xp)
  end
  
end
