class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  def not_logged_in
    if current_user == nil
      redirect_to '/'
      flash[:error] = 'You are currently not logged in and are unable to view this page'
    end
  end
  
end
