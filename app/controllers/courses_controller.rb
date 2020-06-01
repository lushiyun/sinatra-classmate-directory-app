class CoursesController < ApplicationController
  before do
    login_required
  end

  get '/courses' do
    @courses = current_user.courses
    erb :"courses/index"
  end

  get '/courses/new' do
    erb :"courses/new"
  end

  post '/courses' do
    @course = Course.new(params)
    if @course.valid?
      @course.user = current_user
      @course.save
      erb :"courses/show"
    else 
      flash[:alerts] = @course.errors.full_messages
      redirect to "/courses/new"
    end
  end

  get '/courses/:id' do
    if authorized?
      erb :"courses/show"
    else 
      reroute
    end
  end

  get '/courses/:id/edit' do
    if authorized?
      erb :"courses/edit"
    else 
      reroute
    end 
  end

  patch '/courses/:id' do
    if authorized?
      if @course.update(params[:course])
        redirect to "/courses/#{@course.id}"
      else 
        flash[:alerts] = course.errors.full_messages
        redirect to "/courses/#{course.id}/edit"
      end
    else 
      reroute
    end
  end

  delete '/courses/:id' do
    if authorized?
      current_user.courses.destroy(@course)
      redirect to "/courses"
    else 
      reroute
    end
  end

  private

  def authorized?
    @course = current_user.courses.find_by(id: params[:id])
  end
  
  def reroute
    flash[:alerts] = ["You don't have permission"]
    redirect to "/courses"
  end

end