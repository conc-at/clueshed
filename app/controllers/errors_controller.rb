class ErrorsController < ApplicationController
  def show
    @status = status_code
    response.status = @status
    @message = response.message
    render 'error'
  end

  # auch protected und private einrücken
protected
  def status_code
    params[:code] || 500
  end
end
