class TweetsController < ApplicationController
  
    def create
        token = cookies.permanent.signed[:twitter_session_token]
        session = Session.find_by(token: token)
        @user = session.user

        if @user
            @tweet = Tweet.create(
            message: 'Test Message'
        )
            render 'tweets/create'
        else
            render json: { error: 'Invalid session' }, status: :unauthorized
        end
    end

    def index
        token = cookies.permanent.signed[:twitter_session_token]
        session = Session.find_by(token: token)
    
        @tweets = Tweet.all.order("id DESC")

        render 'tweets/index'
    
   

    end

    def destroy
        token = cookies.permanent.signed[:twitter_session_token]
        session = Session.find_by(token: token)
        
        user = session&.user

        @tweet = user&.tweets&.find_by(id: params[:id])

            if @tweet and @tweet.destroy   

                render json: { success: true }
            else

                render json: { success: false }

            end
    end

    def index_by_user
        token = cookies.permanent.signed[:twitter_session_token]
        session = Session.find_by(token: token)

        user = User.find_by(username: params[:username])

        if user
            @tweets = user.tweets
            
            render 'tweets/index_by_user'
        end
        
    end


end
