class SessionsController < ApplicationController


    def create
        user = User.find_by(username:params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user
        else
            render json:{message:'Invalid username/password'}, status: :unauthorized
        end
    end

    # POST /login
    def create
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: { error: "Not authorized" }, status: :unauthorized
        end
    end

    # DELETE /logout
    def destroy
        session.delete :user_id
        head :no_content
    end

end
