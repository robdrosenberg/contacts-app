class UsersController < ApplicationController
  def create
    new_user = User.new(
        name: params[:name],
        email: params[:email],
        password: params[:password],
      )
    if new_user.save
      render json: {message: "User created"}, status: :created
    else
      render json: {errors: new_user.errors.full_messages}, status: :bad_request
    end
  end
end
