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
      session[:user_id] = @user.id
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find_by(id: params[:id])

    if not @user.present?
      redirect_to users_path, notice: "User does not exist"
    end
  end

  def edit

    if Current.user.nil?
      redirect_to new_session_path, notice: "Need to be logged in!"; return
    end
    
    require_user_or_admin params[:id]
    
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

    if @user.update(user_params)
      redirect_to users_path, notice: "Updated successfully"
    else
      puts @user.errors.full_messages
      render :edit
    end
  end

  def destroy
    require_user_or_admin params[:id]

    if Current.user.id == params[:id]
      Current.user = nil
      sessions[:user_id] = nil
    end

    User.find_by(id: params[:id]).destroy
    
    redirect_to users_path, notice: "Deleted user"
  end

  private

  def user_params
    params.require("user").permit(:username, :email, :password, :password_confirmation, :xp)
  end
  
end
