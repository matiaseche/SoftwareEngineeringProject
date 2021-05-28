# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def mis_foros
    @user = User.find(params[:id])
  end

  def mis_publicaciones
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:user_id]).destroy
    redirect_to user_path(current_user), notice: 'User deleted.'
  end
end
