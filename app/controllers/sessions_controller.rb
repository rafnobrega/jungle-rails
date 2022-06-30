class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
    # if user = User.authenticate_with_credentials(params[:email].strip, params[:password])
      
      
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to '/'
    else
      # If user's login doesn't work, send them back to the login form.
      flash[:alert] = "Something went wrong. Please try again."
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end


end