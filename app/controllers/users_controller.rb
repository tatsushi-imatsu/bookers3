class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @relationship = current_user.relationships.find_by(followed_id: @user.id)
    @set_relationship = current_user.relationships.new
  end

  def index
    @users = User.all
    @book = Book.new
    @set_relationship = current_user.relationships.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render:edit
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
     @user.update(user_params)
    if @user.save
       redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      @users = User.find(params[:id])
      render :edit
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @users = @user.followings.all
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.all
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
