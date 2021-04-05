class RelationshipsController < ApplicationController

  before_action :set_follower

  def create
    following = current_user.follow(@follower)
     following.save
     redirect_back(fallback_location: root_path)
  end

  def destroy
     following = current_user.unfollow(@follower)
     following.destroy
     redirect_back(fallback_location: root_path)
  end

  def show
  end

  private
  def set_follower
    @follower = User.find(params[:relationship][:followed_id])
  end

end

