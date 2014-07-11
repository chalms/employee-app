class ManagersController < ApplicationController

  def index
    user = current_user
    validate_index_role!
    @users = Manager.all.where(company_id: user.id, role: 'manager')
    @users.each { |u| u = ManagerSerializer.new(u) }
    respond_to do |format|
      format.html{ render haml: @users }
      format.json{ render json: @users }
    end
  end

  def show
    @user = Manager.all.find(current_user.id)
    is_manager!
    respond_to do |format|
      format.html{ render haml: @user }
      format.json{ render json: @user }
    end
  end

  def update
    @user = current_user
    is_manager!
    params = washing_machine(params)
    user = Manager.all.find(params[:id])
    user.update(params)
    @manager = ManagerSerializer.new(user)
    respond_to do |format|
      format.html { render haml: @manager }
      format.json { render json: @manager }
    end
  end

  def delete
    @user = current_user
    is_admin!
    user_to_delete = Manager.find(params[:id])
    validate_delete!(user_to_delete)
    @user.self_destruct
  end


  private

  def washing_machine(params)
    (params[:manager] || params)
  end

  def validate_delete!(user_to_delete)
    raise Exceptions::StdError, "Invalid user id for delete!" unless (user_to_delete)
    raise Exceptions::StdError, "Cannot delete a user from a different company" unless ((user_to_delete.company == @user.company) && (user.company != nil))
    raise Exceptions::StdError, "Cannot delete an admin" if (user_to_delete.is_admin?)
  end

  def is_admin!
    raise Exceptions::StdError, "Must be an admin to delete manager" unless @user.is_admin?
  end


  def validate_index_role!
    raise Exceptions::StdError, "invalid permissions to access!" unless ((user.role == 'companyAdmin') || (user.role == 'manager'))
  end

  def is_manager!
    raise Exceptions::StdError, "Cannot access: you are not a manager !" unless (@user.role == 'manager')
    @user
  end
end
