class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json
  # skip_before_action :verify_authenticity_token  
  def index 
    respond_with User.search(params)
  end

  def show
    respond_with User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end
  
  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    head 204
  end

private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
