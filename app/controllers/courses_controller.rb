class CoursesController < ApplicationController
  before do
    login_required
  end

  get '/courses' do
    @courses = current_user.courses
    erb :"/courses/index"
  end

  get '/courses/new' do
    erb :"/courses/new"
  end

  post '/courses' do
    course = Course.new(params)
    if course.valid?
      course.user = current_user
      course.save
    else 
      flash[:alerts] =  course.errors.full_messages
      redirect to "/courses/new"
    end
  end

  get '/courses/:id' do
    if @course = current_user.courses.find_by(id: params[:id])
      erb :"courses/show"
    else 
      flash[:alerts] = ["Can't find the course"]
      redirect to "/courses"
    end
  end

  get '/courses/:id/edit' do
    if @course = current_user.courses.find_by(id: params[:id])
      erb :"courses/edit"
    else 
      flash[:alerts] = ["Can't find the course"]
      redirect to "/courses"
    end 
  end

  patch '/courses/:id' do
    course = current_user.courses.find_by(id: params[:id])
    if course.update(params)
      redirect to "/courses/#{course.id}"
    else 
      flash[:alerts] = course.errors.full_messages
      redirect to "/courses/#{course.id}/edit"
    end
  end

  delete '/courses/:id' do
    course = Course.find_by(id: params[:id])
    current_user.courses.destroy(course)
  end

end