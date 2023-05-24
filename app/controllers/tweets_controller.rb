class TweetsController < ApplicationController
  def create
    token = cookies.permanent.signed[:twitter_session_token]
    session = Session.find_by(token: token)
    @user = session.user

    if @user
      @tweet = @user.tweets.create!(
        message: 'Test Message'
      )
      render 'tweets/create'
    else
      render json: { error: 'Invalid session' }, status: :unauthorized
    end
  end

  def index
    @tweets = Tweet.all.order('id DESC')

    render 'tweets/index'
  end

  def destroy
    token = cookies.permanent.signed[:twitter_session_token]
    session = Session.find_by(token: token)

    return render json: { success: false } unless session

    user = session.user
    tweet = user.tweets.find_by(id: params[:id])

    return render json: { success: false } unless tweet

    tweet.destroy
    render json: { success: true }
  end

  def index_by_user
    user = User.find_by(username: params[:username])

    return render json: { success: false } unless user

    @tweets = user.tweets

    render 'tweets/index_by_user'
  end
end
