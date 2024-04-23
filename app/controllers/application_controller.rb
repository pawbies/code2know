class ApplicationController < ActionController::Base

  before_action :set_current_user
  
  def set_current_user
    if session[:user_id]
      Current.user = User.find_by(id: session[:user_id])
    end
  end
  
  def require_admin
    if Current.user == nil || Current.user.role.permission < 4
      redirect_to new_session_path, notice: "Need to be an admin for that"
    end
  end

  def require_user_or_admin id
    if Current.user == nil || (Current.user.id != id.to_i && Current.user.role.permission < 4)
      redirect_to new_session_path, notice: "Need to be logged in for that"
    end
  end

  def require_some_user
    redirect_to new_session_path, notice: "Need to be logged in for that" if Current.user.nil?
  end
end
