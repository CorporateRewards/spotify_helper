class NicknamesController < ApplicationController
  def show
    @nicknames = Nickname.all
  end

  def new
    @nickname = Nickname.new
  end

  def create
    @nickname = Nickname.new(nickname_params)
    @nickname.user = current_user
    if @nickname.save
      flash.notice = "Nickname created!"
      redirect_to nicknames_path
    else
      flash.now[:error] = "Sorry, there was a problem creating your nickname"
      render :new
    end
  end

  def edit

  end

private

  def nickname_params
    params.require(:nickname).permit(:nickname, :hidden, :chosen_at, :user)      
  end
end
