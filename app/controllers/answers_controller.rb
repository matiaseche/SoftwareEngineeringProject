# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :set_forum_thread

  def vote
    redirect_to forum_thread_path(@forum_thread)
  end

  private

  def set_forum_thread
    @forum_thread = ForumThread.find(params[:forum_thread_id])
  end
end
