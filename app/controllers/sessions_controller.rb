class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:session][:password] == "123"
      session[:login] = "ok"
      redirect_to session[:referer]
    else
      flash.now[:danger] = 'パスワードが違います'
      render 'new'
    end  
  end

  def destroy
  end
end
