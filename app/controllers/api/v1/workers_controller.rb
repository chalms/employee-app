class Api::V1::WorkersController < ApplicationController
  before_filter :authenticate_worker!

  respond_to :json

  # GET /outlet_types
  def index
    authorize! :read, Worker
    users =  current_worker.admin? ? Worker.all : [current_user]
    render json: workers, status: :ok
  end

end
