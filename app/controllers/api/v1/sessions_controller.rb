module Api::V1
  class SessionsController < ApplicationController

    def create
      if params[:password] || params[:password] != ""
        user = User.find_by(username: params[:username])
        if user.present?
          if user.authenticate(params[:password])
            render json: user
          else
            render json: {errors: "Username or password did not match."}
          end
        else
          render json: {errors: "Username does not exist."}
        end
      else
        render json: {errors: "Password cannot be empty."}
      end
    end

  end
end
