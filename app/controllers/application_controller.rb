class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def user_logged_in?
    if session[:login] == 'ok'
        return
    end
    session[:referer] = request.fullpath
    redirect_to login_path
end    

def logout
  session[:login] = nil
end

end
