class TweetsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def show
    @tweets = @user.tweets.order(id: :desc).page(params[:page])
  end
  
  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:success] = 'ツイートを投稿しました。'
      redirect_to root_url
    else
      @tweets = current_user.feed_tweets.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'ツイートの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @tweet.destroy
    flash[:success] = "ツイートを削除しました。"
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def tweet_params
    params.require(:tweet).permit(:content)
  end
  
  def correct_user
    @tweet = current_user.tweets.find_by(id: params[:id])
    unless @tweet
      redirect_to root_url
    end
  end
end