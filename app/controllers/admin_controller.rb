class AdminController < ApplicationController
  # GET /users/1
  # GET /users/1.json
  def show
    @user = Admin.find(params[:id])
    render json: @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = Admin.new(params[:user])
    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = Admin.find(params[:id])

    if @user.update(params[:user])
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = Admin.find(params[:id])
    @user.destroy

    head :no_content
  end
end