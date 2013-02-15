class SessionsController < ApplicationController
  
  def create
    oauth = request.env['omniauth.auth']
    if user_signed_in?
      user_auth = current_user.authentications.find_by(provider: oauth['provider'], uid: oauth['uid'])
      if user_auth
        redirect_to root_path, notice: "You already has your #{oauth['provider']} account linked."
      else
        if current_user.save(oauth)
          redirect_to authentications_path, notice: "Your new #{oauth['provider']} account has been linked successfully!"
        else
          flash[:error] = user.errors.full_messages
          redirect_to root_url
        end       
      end
    else # user is NOT signed in
      auth = Authentication.find_by(provider: oauth['provider'], uid: oauth['uid'])
      if auth
        session[:user_id] = auth.user.id
        redirect_to root_url, notice: 'Awwww Yeah! Welcome back!'
      else
        user = User.new
        if user.save(oauth)
          session[:user_id] = user.id
          redirect_to root_url, notice: 'You are in! Welcome!'
        else
          flash[:error] = user.errors.full_messages
          redirect_to root_url
        end
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "See you later, maybe!"
  end
end