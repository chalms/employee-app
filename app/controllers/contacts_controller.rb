class ContactsController < ApplicationController

  include ActionController::MimeResponds

  def show

  end

  def new
    @user = current_user
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
    puts params
    puts "getting current user"
    @user = current_user
    puts "user -> #{@user.inspect}"
    puts "@user.company.clients"
    clients = @user.company.clients
    puts "clients -> #{clients.inspect}"
    puts "client.find(params[:id])"
    client = clients.find(params[:id])
    puts "client -> #{client.inspect}"
    Contact.create({
      :name => params[:name],
      :email => params[:email],
      :phone => params[:phone],
      :client_id => params[:id],
      :company_id => @user.company.clients,
      :user_id => @user.id
    })
    json_arr = []
    Contact.where(:client_id => client.id).each do |c|
      json_arr << c.as_json
    end

    puts "json_arr -> #{json_arr.inspect}"

    respond_to do |format|
      format.json { render json: json_arr }
    end
  end



  private


  def user!
    @user = current_user
    validate_user!
  end

  def validate_user!
    raise Exceptions::StdError, "Invalid permissions!" unless @user.role.downcase != 'employee'
  end
end
