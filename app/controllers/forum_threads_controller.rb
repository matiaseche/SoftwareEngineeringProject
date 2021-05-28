# frozen_string_literal: true

class ForumThreadsController < ApplicationController
  before_action :set_forum_thread, only: %i[show edit update destroy]

  # GET /forum_threads
  # GET /forum_threads.json
  def index
    @q = ForumThread.search(params[:q])
    @forum_threads = @q.result
  end

  # GET /forum_threads/1
  # GET /forum_threads/1.json

  def follows
    @user = current_user # before_action :authenticate_user, only: [:likes]
    @forum_thread = ForumThread.find(params[:id])
    @user.follow!(@forum_thread)
    redirect_to forum_threads_path
  end

  def unfollows
    @user = current_user # before_action :authenticate_user, only: [:likes]
    @forum_thread = ForumThread.find(params[:id])
    @user.unfollow!(@forum_thread)
    redirect_to mis_foros_path(@user)
  end

  def show
    redirect_to forum_thread_forum_posts_path(@forum_thread.id,
                                              forum_thread: @forum_thread)
  end

  # GET /forum_threads/new
  def new
    @forum_thread = ForumThread.new
  end

  # GET /forum_threads/1/edit
  def edit; end

  # POST /forum_threads
  # POST /forum_threads.json
  def create
    @forum_thread = ForumThread.new(forum_thread_params)
    @forum_thread.user = current_user

    respond_to do |format|
      if @forum_thread.save
        current_user.follow!(@forum_thread)
        format.html do
          redirect_to @forum_thread,
                      notice: 'Forum thread was successfully created.'
        end
        format.json { render :show, status: :created, location: @forum_thread }
      else
        format.html { render :new }
        format.json do
          render json: @forum_thread.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /forum_threads/1
  # PATCH/PUT /forum_threads/1.json
  def update
    respond_to do |format|
      if @forum_thread.update(forum_thread_params)
        format.html do
          redirect_to @forum_thread,
                      notice: 'Forum thread was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @forum_thread }
      else
        format.html { render :edit }
        format.json do
          render json: @forum_thread.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /forum_threads/1
  # DELETE /forum_threads/1.json
  def destroy
    @forum_thread.destroy
    respond_to do |format|
      format.html do
        redirect_to forum_threads_url,
                    notice: 'Forum thread was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  def set_forum_thread
    @forum_thread = ForumThread.find(params[:id])
  end

  def forum_thread_params
    params.require(:forum_thread).permit(:user_id, :subject, :forum_thread_id)
  end
end
