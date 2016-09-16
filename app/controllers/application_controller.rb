class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  def not_logged_in
    if current_user == nil
      flash[:error] = 'You are currently not logged in and are unable to view this page'
      redirect_to '/'
    end
  end

end
