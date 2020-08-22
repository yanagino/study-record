class RecordsController < ApplicationController
before_action :logged_in?
before_action :forbid_different_user, only: [:edit, :show, :destroy, :update]

  def new
    @record = Record.new
  end

  def create
    @record = @current_user.records.build(record_params)

    if @record.save
      flash[:success] = "投稿が完了しました"
      redirect_to("/mypage")
    else
      flash.now[:danger] = "投稿できませんでした"
      render("records/new")
    end
  end

  def edit
    @record = @current_user.records.find_by(id: params[:id])
  end

  def update
    @record = @current_user.records.find_by(id: params[:id])
    
    if @record.update(record_params)
      flash[:success] = "勉強記録を修正しました"
      redirect_to("/records/#{@record.id}")
    else
      flash.now[:danger] = "勉強記録を修正できませんでした"
      render("records/#{@record.id}/edit")
    end
  end

  def destroy
    @record = @current_user.records.find_by(id: params[:id])
    @record.destroy
    flash[:success] = "勉強記録を削除しました"
    redirect_to("/mypage")
  end

  def show
    @record = Record.find_by(id: params[:id])
  end

  def search
    @keyword = params[:keyword]

    unless @keyword == ""
      @records = Record.where(user_id: @current_user.id).where("content LIKE(?) OR memo LIKE(?) OR study LIKE(?)", "%#{@keyword}%", "%#{@keyword}%", "%#{@keyword}%").order(date: "DESC").all.page(params[:page]).per(10)
    else
      flash[:danger] = "キーワードが入力されていません"
      redirect_to("/mypage")
    end
  end

  private
  def record_params
    params.require(:record).permit(:date, :hour, :content, :memo, :study)
  end

end
