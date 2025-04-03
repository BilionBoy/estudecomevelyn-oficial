class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :produtos, :cursos, :blog]
  def index
  end

  def produtos
  end

  def cursos
  end

  def blog
  end
end
