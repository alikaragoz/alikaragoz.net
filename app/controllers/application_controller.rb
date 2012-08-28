class ApplicationController < ActionController::Base
  protect_from_forgery
  
  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: :render_500
    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from ActionController::UnknownController, with: :render_404
    rescue_from ActionController::UnknownAction, with: :render_404
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
  end

  protected

  def prepare_session
    if !session[:last_seen].nil? and session[:last_seen] < Time.now
		  # Session has expired. Clear the current session.
      reset_session
    end

    # Assign a new expiry time, whether the session has expired or not.
    session[:last_seen] = 1.hour.from_now
    return true
  end

  def authenticated?
    if session[:logged_in]
      return true
    else
      return false
    end
  end

  def authenticated
    session[:logged_in] = true
  end

  # Server Errors

  private
  def render_404(exception)
    logger.info "Not Found: '#{request.fullpath}'.\n#{exception.class} error was raised for path .\n#{exception.message}"
    @not_found_path = exception.message
    respond_to do |format|
      format.html { render template: 'errors/error_404', layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  def render_500(exception)
    logger.info "System Error: Tried to access '#{request.fullpath}'.\n#{exception.class} error was raised for path .\n#{exception.message}"
    @error = exception
    respond_to do |format|
      format.html { render template: 'errors/error_500', layout: 'layouts/application', status: 500 }
      format.all { render nothing: true, status: 500}
    end
  end
  
end