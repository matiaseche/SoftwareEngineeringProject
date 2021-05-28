# frozen_string_literal: true

class RequestsController < ApplicationController
  before_action :set_request, only: %i[show edit update destroy]
  before_action :set_forum_thread

  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.all
  end

  # GET /requests/1
  # GET /requests/1.json
  def show; end

  def aceptar
    @request = Request.find(params[:request_id])
    @request.state = 'Aceptado'
    @request.save

    redirect_to user_path(current_user)
  end

  def rechazar
    @request = Request.find(params[:request_id])
    @request.state = 'Rechazado'
    @request.save

    redirect_to user_path(current_user)
  end

  # GET /requests/new
  def new
    @request = @forum_thread.requests.build
  end

  # GET /requests/1/edit
  def edit
    @request = Request.find(params[:id])
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = @forum_thread.requests.build(user_id: current_user.id,
                                            forum_thread_id: :forum_thread_id)

    respond_to do |format|
      if @request.save
        format.html do
          redirect_to @forum_thread,
                      notice: 'Request was successfully created.'
        end
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new }
        format.json do
          render json: @request.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html do
          redirect_to @request,
                      notice: 'Request was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit }
        format.json do
          render json: @request.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html do
        redirect_to requests_url,
                    notice: 'Request was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_request
    @request = Request.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def request_params
    params.require(:request).permit(:user_id, :forum_thread_id)
  end

  def set_forum_thread
    @forum_thread = ForumThread.find(params[:forum_thread_id])
  end
end
