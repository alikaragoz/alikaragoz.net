class LoginController < ApplicationController

  before_filter :prepare_session
  http_basic_authenticate_with :name => ENV['ADMIN_USERNAME'], :password => ENV['ADMIN_PASSWORD'], :except => :logout

  def login
    redirect_to new_post_url
  end

  def logout
    reset_session
    redirect_to :root
  end  

end