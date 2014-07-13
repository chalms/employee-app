class AdminsController < ApplicationController
  # GET /users/1
  # GET /users/1.json
  def show
    @user = Admin.all.find(params[:id])
    is_admin!
    respond_to do |format|
      format.html{ render haml: @user }
      format.json{ render json: @user }
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
end