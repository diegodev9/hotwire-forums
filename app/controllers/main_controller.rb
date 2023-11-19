class MainController < ApplicationController
  def index
    flash.now[:notice] = 'prueba'
    flash.now[:alert] = 'prueba'
  end
end
