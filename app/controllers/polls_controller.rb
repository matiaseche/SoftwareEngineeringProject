# frozen_string_literal: true

class PollsController < ApplicationController
  before_action :set_forum_thread
  before_action :set_poll, only: %i[show edit update destroy]

  # GET /polls
  # GET /polls.json
  def index
    @polls = @forum_thread.polls.all
  end

  # GET /polls/1
  # GET /polls/1.json
  def show; end

  # GET /polls/new
  def new
    @poll = @forum_thread.polls.build
    2.times { @poll.answers.build }
  end

  # GET /polls/1/edit
  def edit; end

  # POST /polls
  # POST /polls.json
  def create
    @poll = @forum_thread.polls.build(poll_params)
    @poll.user         = current_user
    @poll.forum_thread = @forum_thread
    @poll.save

    respond_to do |format|
      if @poll.save
        format.html do
          redirect_to @forum_thread,
                      notice: 'Poll was successfully created.'
        end
        format.json { render :show, status: :created, location: @poll }
      else
        format.html { render :new }
        format.json do
          render json: @poll.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /polls/1
  # PATCH/PUT /polls/1.json
  def update
    @poll = @forum_thread.polls.find(params[:id])

    respond_to do |format|
      if @poll.update(poll_params)
        format.html do
          redirect_to @forum_thread,
                      notice: 'Poll was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @poll }
      else
        format.html { render :edit }
        format.json do
          render json: @poll.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    @poll.destroy
    respond_to do |format|
      format.html do
        redirect_to polls_url,
                    notice: 'Poll was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_forum_thread
    @forum_thread = ForumThread.find(params[:forum_thread_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def poll_params
    params.require(:poll).permit(:question, :user_id, :forum_thread_id,
                                 answers_attributes:
                                  %i[id content votes poll_id])
  end
end
