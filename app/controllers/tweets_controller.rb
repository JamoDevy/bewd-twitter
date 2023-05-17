class TweetsController < ApplicationController

    def create
        @user = User.find_by(username: params[:username])
        
        if @user == params[:username]
            @tweet = Tweet.create(

                message: 'Test Message'
                
            )
            render 'tweets/create.jbuilder'
        end
        
    end

end
