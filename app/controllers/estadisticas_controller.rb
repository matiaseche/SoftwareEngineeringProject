# frozen_string_literal: true

class EstadisticasController < ApplicationController
  def show
    @users = User.all
    @forum_threads = ForumThread.all
  end

  def users_day
    render json: User.group_by_day(:created_at).count
  end
end
