class UsersController < ApplicationController

    def create
        @user = User.create(
            username: 'test',
            email: 'test@test.com',
            password: 'asdasdasd'
        )

        render 'users/create'
    end
end
