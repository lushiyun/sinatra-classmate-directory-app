class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  use Rack::Flash

  configure do
    enable :sessions
    set :session_secret, "#{ENV['SESSION_SECRET']}"
    set :public_folder, Proc.new { File.join(root, "public") }
    set :views, 'app/views'
  end

  get '/' do
    erb :index
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

    def sanitize_input(input_hash)
      input_hash.transform_values! { |v| v.gsub(/[\<\>\/]/, "") }
    end

    def create_classmate(success_route, fail_route)
      sanitize_input(params[:classmate])
      @classmate = current_user.classmates.find_or_create_by(params[:classmate])
      if @classmate.valid?
        params[:course_ids].each do |course_id|
          ClassmateCourse.create(course_id: course_id, classmate_id: @classmate.id) unless Course.find(course_id).classmates.include?(@classmate)
        end
        redirect to success_route
      else
        flash[:alerts] = @classmate.errors.full_messages
        redirect to fail_route
      end
    end

    def update_classmate(success_route, fail_route)
      sanitize_input(params[:classmate])
      @classmate = current_user.classmates.find_by_id(params[:id])
      if @classmate.update(params[:classmate])
        course_array = Course.find(params[:course_ids])
        @classmate.courses.replace(course_array)
      redirect to success_route
      else
        flash[:alerts] = @classmate.errors.full_messages
        redirect to fail_route
      end
    end
  end
  
end