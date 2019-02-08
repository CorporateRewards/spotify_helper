class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.skip_password_validation = true
    if @user.save
      flash.notice = 'User created!'
      render :show
    else
      flash.now[:error] = 'Sorry, there was a problem creating your user'
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy; end

  private

  def user_params
    params.require(:user).permit(:id, :email, :first_name, :last_name)
  end

  def password_required?; end
end
