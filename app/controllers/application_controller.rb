class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  use Rack::Flash

  configure do
    enable :sessions
    set :session_secret, "#{ENV['SESSION_SECRET']}"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  not_found do
    status 404
    erb :not_found
  end

  helpers do

    def logged_in?
      !!current_user
    end
  
    def current_user
      @user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end
  
    def login_required
      if !logged_in?
        flash[:alerts] = ["You must log in."]
        redirect to "/"
      end
    end

    def sanitize_input
      params.each_with_object({}) do |(k, v), new|
        if v.is_a? String
          new[k] = v.gsub(/[\<\>\/]/, "")
        elsif v.is_a? Array
          sanitized_array = v.map! { |arr_v| arr_v.gsub(/[\<\>\/]/, "") }
          new[k] = sanitized_array
        else
          sanitized_hash = v.transform_values! { |hash_v| hash_v.gsub(/[\<\>\/]/, "") }
          new[k] = sanitized_hash
        end
      end
    end

    def create_classmate(success_route, fail_route)
      sanitize_input
      @classmate = current_user.classmates.find_or_create_by(params[:classmate]) 
      if @classmate.valid?
        @classmate.course_ids = params[:course_ids]
        redirect to success_route
      else
        flash[:alerts] = @classmate.errors.full_messages
        redirect to fail_route
      end
    end

    def update_classmate(success_route, fail_route)
      sanitize_input
      if @classmate.update(params[:classmate])
        @classmate.course_ids = params[:course_ids]
        redirect to success_route
      else
        flash[:alerts] = @classmate.errors.full_messages
        redirect to fail_route
      end
    end
  end
  
end