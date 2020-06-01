class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  use Rack::Flash

  configure do
    enable :sessions
    set :session_secret, "top_secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to "/login"
  end

  helpers do
    def logged_in?
      !!current_user
    end
  
    def current_user
      @user ||= User.find(session[:user_id]) if session[:user_id]
    end
  
    def login_required
      if !logged_in?
        flash[:alerts] = ["You must log in."]
        redirect to "/"
      end
    end

    def authorized_for_classmate
      @classmate = current_user.classmates.find_by(id: params[:id])
    end

    def classmate_unauthorized
      flash[:alerts] = ["Classmate not found"]
      redirect to "/classmates"
    end

  end
end