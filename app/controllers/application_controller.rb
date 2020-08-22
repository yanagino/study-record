class ApplicationController < ActionController::Base
before_action :current_user

  def current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def logged_in?
    unless @current_user
      flash[:warning] = "ログインが必要です"
      redirect_to("/login")
    end
  end

  def login_user?
    if @current_user
        flash[:warning] = "すでにログインしています"
        redirect_to("/mypage")
    end
  end

  def forbid_different_user
    record = Record.find_by(id: params[:id])
    unless @current_user.id == record.user_id
      flash[:warning] = "権限がありません"
      redirect_to("/mypage")
    end
  end

end
