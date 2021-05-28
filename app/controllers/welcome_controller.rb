# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    redirect_to forum_threads_path
  end
end
