class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @users = User.all
    @side_bar = { user: current_user, form_value: Book.new }
    render layout: 'two_columns'
  end

  def show
    @books = @user.books
    @side_bar = { user: @user, form_value: Book.new }
    render layout: 'two_columns'
  end

  def edit
    @form_value = @user
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'You have updated user successfully.'
      redirect_to user_path(@user.id)
    else
      @form_value = @user
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def is_matching_login_user
    unless @user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
