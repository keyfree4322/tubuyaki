class FavoritesController < ApplicationController
  def create
    @favorite = current_user.favorites.create(tweet_id: params[:tweet_id])
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @favorite = current_user.favorites.find_by(tweet_id: @tweet.id)
    @favorite.destroy
    redirect_back(fallback_location: root_path)
  end
end