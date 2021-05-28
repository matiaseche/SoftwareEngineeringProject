# frozen_string_literal: true

class ForumPostsController < ApplicationController
  before_action :set_forum_thread

  def index
    @q = @forum_thread.forum_posts.search(params[:q])
    @forum_posts = @q.result
  end

  def new
    @forum_post = @forum_thread.forum_posts.build
  end

  def favoritos
    @user = current_user # before_action :authenticate_user, only: [:likes]
    @forum_post = @forum_thread.forum_posts.find(params[:forum_post_id])
    @user.follow!(@forum_post)
    redirect_to forum_thread_forum_posts_url
  end

  def sacar_favoritos
    @user = current_user # before_action :authenticate_user, only: [:likes]
    @forum_post = @forum_thread.forum_posts.find(params[:forum_post_id])
    @user.unfollow!(@forum_post)
    redirect_to mis_publicaciones_path(@user)
  end

  def dislikes
    @user = current_user # before_action :authenticate_user, only: [:likes]
    @forum_post = @forum_thread.forum_posts.find(params[:forum_post_id])
    @forum_post.disliked_by @user
    redirect_to forum_thread_forum_posts_url
  end

  def likes
    @user = current_user # before_action :authenticate_user, only: [:likes]
    @forum_post = @forum_thread.forum_posts.find(params[:forum_post_id])
    @forum_post.liked_by @user
    redirect_to forum_thread_forum_posts_url
  end

  def edit
    @forum_post = @forum_thread.forum_posts.find(params[:id])
  end

  def show
    @forum_post = @forum_thread.forum_posts.find(params[:id])
  end

  def update
    @forum_post = @forum_thread.forum_posts.find(params[:id])
    respond_to do |format|
      if @forum_post.update(forum_post_params)
        format.html do
          redirect_to forum_thread_forum_posts_url,
                      notice: 'Publicación correctamente actualizada.'
        end
        format.json { render :show, status: :ok, location: @forum_post }
      else
        format.html { render :edit }
        format.json do
          render json: @forum_post.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def create
    @forum_post = @forum_thread.forum_posts.build(
      forum_post_params
    )
    @forum_post.user         = current_user
    @forum_post.forum_thread = @forum_thread
    @forum_post.save

    redirect_to forum_thread_forum_posts_url
  end

  def destroy
    @forum_post = @forum_thread.forum_posts.find(params[:id]).destroy

    redirect_to forum_thread_forum_posts_url
  end

  private

  def set_forum_thread
    @forum_thread = ForumThread.find(params[:forum_thread_id])
  end

  def forum_post_params
    params.require(:forum_post).permit(:forum_thread_id, :user_id, :title,
                                       :body, :forum_post_id)
  end
end
