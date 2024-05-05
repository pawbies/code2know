class UsersController < ApplicationController
  before_action :fetch_user, only: %i[show edit update destroy]
  before_action :require_this_user, only: %i[edit update destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: 'Successfully created User'
      session[:user_id] = @user.id
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'Updated successfully'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if Current.user.id == params[:id]
      Current.user = nil
      sessions[:user_id] = nil
    end

    @user.destoy

    redirect_to users_path, notice: 'Deleted user'
  end

  private

  def require_this_user
    require_user_or_admin params[:id]
  end

  def fetch_user
    @user = User.find_by(id: params[:id])
    redirect_to user_path, notice: 'User does not exist' if @user.nil?
  end

  def user_params
    params.require('user').permit(:username, :email, :password, :password_confirmation, :xp, :pfp)
  end
end
