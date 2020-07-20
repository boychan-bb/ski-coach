class TweetsController < ApplicationController
  before_action :move_to_index, except: :index
  
  def index
    @tweets = Tweet.all.order("id DESC").includes(:user)
  end
  
  def new
  end
  
  def create
    Tweet.create(name: tweet_params[:name], text: tweet_params[:text], recommend: tweet_params[:recommend], user_id: current_user.id)
  end
  
  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy if current_user.id == tweet.user_id
  end
  
  def edit
    @tweet = Tweet.find(params[:id])
  end
  
  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params) if current_user.id == tweet.user_id
  end
  
  def show
    @tweet = Tweet.find(params[:id])
  end
  
  def info 
  end
  
  private
  def tweet_params
    params.permit(:name, :text, :recommend)
  end
  
  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end