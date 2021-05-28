# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_forum_thread

  def index
    @user = current_user
    @forum_post = @forum_thread.forum_posts.find(params[:forum_post_id].to_i)
  end

  def likes
    @user = current_user # before_action :authenticate_user, only: [:likes]
    @forum_post = @forum_thread.forum_posts.find(params[:forum_post_id].to_i)
    @comment = @forum_post.comments.find(params[:comment_id])
    @comment.liked_by @user
    redirect_to forum_thread_forum_post_path(@forum_thread, @forum_post)
  end

  def dislikes
    @user = current_user # before_action :authenticate_user, only: [:likes]
    @forum_post = @forum_thread.forum_posts.find(params[:forum_post_id].to_i)
    @comment = @forum_post.comments.find(params[:comment_id])
    @comment.disliked_by @user
    redirect_to forum_thread_forum_post_path(@forum_thread, @forum_post)
  end

  def create
    @forum_post   = @forum_thread.forum_posts.find(params[:forum_post_id].to_i)
    @comment      = @forum_post.comments.build(comment_params)
    @comment.user = current_user
    @comment.save

    redirect_to forum_thread_forum_post_path(@forum_thread, @forum_post)
  end

  def destroy
    @forum_post = @forum_thread.forum_posts.find(params[:forum_post_id].to_i)
    @comment    = @forum_post.comments.find(params[:id]).destroy

    redirect_to forum_thread_forum_post_path(@forum_thread, @forum_post)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_forum_thread
    @forum_thread = ForumThread.find(params[:forum_thread_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:content)
  end

  def forum_post_params
    params.require(:forum_post).permit(:forum_thread_id, :user_id, :title,
                                       :body)
  end
end
