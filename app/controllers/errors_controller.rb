class ErrorsController < ApplicationController
  layout 'application'

  def not_found
    render status: :not_found  
  end

  def internal_error
    render status: :internal_error
  end

  def unprocessable_entity
    render status: :unprocessable_entity
  end

  # def error404
  #   render status: :not_found
  # end

  # def error500
  #   render status: :not_found
  # end
end