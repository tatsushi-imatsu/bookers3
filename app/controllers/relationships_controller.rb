class RelationshipsController < ApplicationController
  
  def create
    user = User.find(params[:user_id])
    favorite = current_user.favorites.new(user_id: user.id)
    favorite.save
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    user = User.find(params[:user_id])
    favorite = current_user.favorites.find_by(user_id: user.id)
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end
  
end
