class ClientsController < ApplicationController
  # GET /api/clients
  # GET /api/clients.json
  include ActionController::MimeResponds

  def index
    @user = current_user
    @data = params[:data]
    puts params
    if @data[:options][:project_id].present?
      @data[:project] =  Project.find(@data[:options][:project_id])

      @data[:clients] = Client.where(:project_id => @data[:options][:project_id]).all
    end
    @div = @data.delete(:div)
    respond_to do |format|
      format.json { render json: @clients };
      format.js
    end
  rescue Exceptions::StdError => e
    redirect_to :root_url
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
