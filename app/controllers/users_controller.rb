class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    puts "got to create"
    @user = User.new(user_params)

    if @user.save
      puts "it worked"
      redirect_to users_path
    else
      puts "shit"
      render :new
    end
  end

  private

  def user_params
    params.require("user").permit(:username, :email, :password, :password_confirmation)
  end
  
end
