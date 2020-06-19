class UsersController < ApplicationController

  get '/login' do
    reroute_if_logged_in
    erb :login
  end

  get '/signup' do
    reroute_if_logged_in
    erb :signup
  end

  post '/login' do
    sanitize_input(params)
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/courses"
    else 
      flash[:alerts] = ["Wrong email or password. Please try again."]
      redirect to "/login"
    end
  end

  post '/signup' do
    sanitize_input(params)
    user = User.new(params)
    if user.save
      session[:user_id] = user.id
      redirect to "/courses"
    else 
      flash[:alerts] =  user.errors.full_messages
      redirect to "/signup"
    end
  end

  get '/logout' do
    session.clear
    redirect to "/"
  end

  private
  def reroute_if_logged_in
    if logged_in?
      flash[:alerts] = ["You already logged in"]
      redirect to "/courses"
    end
  end

end