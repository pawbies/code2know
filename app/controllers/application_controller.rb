class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_admin
    return unless Current.user.nil? || Current.user.role.permission < 4

    redirect_to new_session_path, notice: 'Need to be an admin for that'
  end

  def require_user_or_admin(id)
    return unless Current.user.nil? || (Current.user.id != id.to_i && Current.user.role.permission < 4)

    redirect_to new_session_path, notice: 'Not allowed to do that'
  end

  def require_some_user
    redirect_to new_session_path, notice: 'Need to be logged in for that' if Current.user.nil?
  end

  def require_admin_or_one_of(ids)
    return unless Current.user.nil? || (!ids.include?(Current.user.id) && Current.user.role.permission < 4)

    redirect_to new_session_path, notice: 'Not allowed to do this'
  end
end
