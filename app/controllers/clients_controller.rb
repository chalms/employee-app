class ClientsController < ApplicationController
  # GET /api/clients
  # GET /api/clients.json
  include ActionController::MimeResponds

  def index
    @user = current_user
    @clients = @user.company.clients
    respond_to do |format|
      format.json { render json: @clients };
      format.html { render @clients };
    end
  rescue Exceptions::StdError => e
    head 500, :content_type => 'text/html'
  end

  # GET /api/clients/1
  # GET /api/clients/1.json
  def show
    @user = current_user
    @client = @user.company.clients.find_by_id(params[:id])
    validate_client!
    respond_to do |format|
      format.json { render json: @client, status: :created };
      format.html { render @client };
    end
rescue Exceptions::StdError => e
    head 500, :content_type => 'text/html'
  end

  # POST /api/clients
  # POST /api/clients.json
  def create
    @user = current_user
    @client = @user.company.clients.create!(clean(params))
    respond_to do |format|
      format.json { render json: @client, status: :created };
      format.html { render @client };
    end
rescue Exceptions::StdError => e
    head 500, :content_type => 'text/html'
  end

  # PATCH/PUT /api/clients/1
  # PATCH/PUT /api/clients/1.json
  def update
    @user = current_user
    params = update_params(params)
    @client = @user.company.clients.find(params[:id])
    valid_client!
    @client.update_attributes!(params[:client])
    respond_to do |format|
      format.json { head 200, :content_type => 'text/html' };
      format.html { head 200 };
    end
rescue Exceptions::StdError => e
    head 500, :content_type => 'text/html'
  end

  # DELETE /api/clients/1
  # DELETE /api/clients/1.json
  def destroy
    @user = current_user
    @client = @user.company.clients.find(params[:id])
    valid_client!
    @client.destroy
    head 200, :content_type => 'text/html'
rescue Exceptions::StdError => e
    head 500, :content_type => 'text/html'
  end

  private

  def valid_client!
    raise Exceptions::StdError, "client does not belong to user" unless @client
  end

  def update_params(params)
    return {
      :id => (params[:client][:id] || params[:id]),
      :client => {
        :name => (params[:client][:name] || params[:name]),
        :locations => (params[:client][:locations] || params[:locations])
      }
    }
  end

  def clean(params)
    params = {
      :name => params[:client][:name],
      :user_id => @user.id
    }
    return params
  end
end
