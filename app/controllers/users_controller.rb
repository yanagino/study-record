class UsersController < ApplicationController
before_action :logged_in?, only: [:show]
before_action :login_user?, only: [:new, :login_form, :create, :login]

  def new
    @user = User.new
  end

  def login_form
  end

  def show
    @display_records = @current_user.records.order(date: "DESC").all.page(params[:page]).per(10)
    sum_hour_total
    sum_hour_monthly
    sum_hour_weekly
  end

  def create
    @user = User.new(password_params)

    if @user.save
      flash[:success] = "登録が完了しました"
      redirect_to("/mypage")
      session[:user_id] = @user.id
    else
      flash.now[:danger] = "登録できませんでした"
      render("users/new")
    end
  end

  def login
    @email = params[:user][:email].downcase
    @password = params[:user][:password]
    @user = User.find_by(email: @email)

    if @user && @user.authenticate(@password)
      session[:user_id] = @user.id
      flash[:success] = "ログインしました"
      redirect_to("/mypage")
    else
      flash.now[:danger] = "メールアドレスまたはパスワードが間違っています"
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "ログアウトしました"
    redirect_to("/login")
  end

  private
  def password_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def sum_hour_total
    @records = @current_user.records
    @sum_total = 0
    @records.each do |record|
      @sum_total += record.hour
    end
    return @sum_total
  end

  def sum_hour_monthly
    this_month = Time.current.month
    @records = @current_user.records
    @sum_monthly = 0
    @records.each do |record|
      if record.date.month == this_month
        @sum_monthly += record.hour
      end
    end
    return @sum_monthly
  end

  def sum_hour_weekly
    this_week = Time.current.strftime("%W")
    @records = @current_user.records
    @sum_weekly = 0
    @records.each do |record|
      if record.date.strftime("%W") == this_week
        @sum_weekly += record.hour
      end
    end
    return @sum_weekly
  end

end
