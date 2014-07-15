class ContactsController < ApplicationController

  include ActionController::MimeResponds
  before_action :user!

  def new
    if (params[:data])
      @data = params[:data]
    end
    if (@params[:div])
      @div = params[:div]
    end
    respond_to do |format|
      format.json { render json: Contact.new }
      format.js
    end
  end

  def create
    @user

  end

  private


  def user!
    @user = current_user
    validate_user!
  end

  def validate_user!
    raise Exceptions::StdError, "Invalid permissions!", unless @user.role.downcase != 'employee'
  end
end
