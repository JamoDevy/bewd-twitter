class TweetsController < ApplicationController
  def create
    token = cookies.permanent.signed[:twitter_session_token]
    session = Session.find_by(token: token)
    @user = session.user

    if @user
      @tweet = Tweet.create(
        message: 'Test Message'
      )
      render 'tweets/create.jbuilder'
    else
      render json: { error: 'Invalid session' }, status: :unauthorized
    end
  end
end
