class UsersController < ApplicationController

  get '/login' do
    erb :login
  end

  get '/signup' do
    erb :signup
  end

  post '/login' do 
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
    user = User.new(params)
    if user.valid?
      user.save
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
end