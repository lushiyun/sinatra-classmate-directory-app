class CoursesController < ApplicationController
  before do
    login_required
  end

  get '/courses' do
    @courses = current_user.courses
    erb :"courses/index"
  end

  post '/courses' do
    sanitize_input(params)
    unless @course = current_user.courses.create(params)
      flash[:alerts] = @course.errors.full_messages
    end 
    redirect to "/courses"
  end

  get '/courses/:id/edit' do
    permission_required(params[:id])
    erb :"courses/edit"
  end

  get '/courses/:id' do
    permission_required(params[:id])
    erb :"courses/show"
  end

  patch '/courses/:id' do
    permission_required(params[:id])
    sanitize_input(params[:course])
    
    if @course.update(params[:course])
      redirect to "/courses"
    else 
      flash[:alerts] = @course.errors.full_messages
      redirect to "/courses/#{@course.id}/edit"
    end
  end

  delete '/courses/:id' do
    permission_required(params[:id])
    current_user.courses.destroy(@course)
    redirect to "/courses"
  end

  get '/courses/:id/classmates/new' do
    permission_required(params[:id])
    @courses = current_user.courses
    erb :"classmates/new"
  end

  post '/courses/:id/classmates' do 
    permission_required(params[:id])
    create_classmate("/courses/#{@course.id}", "/courses/#{@course.id}/classmates/new")
  end

  get '/courses/:course_id/classmates/:classmate_id/edit' do
    permission_required(params[:course_id])
    @courses = current_user.courses
    @classmate = current_user.classmates.find(params[:classmate_id])
    erb :"classmates/edit"
  end

  patch '/courses/:course_id/classmates/:classmate_id' do
    permission_required(params[:course_id])
    update_classmate("/courses/#{@course.id}", "/courses/#{@course.id}/classmates/#{@classmate.id}/edit")
  end

  delete '/courses/:course_id/classmates/:classmate_id' do
    current_user.classmates.destroy(Classmate.find(params[:classmate_id]))
    redirect to "/courses/#{params[:course_id]}"
  end

  private

  def permission_required(id)
    unless @course = current_user.courses.find_by_id(id)
      flash[:alerts] = ["You don't have permission"]
      redirect to "/courses"
    end 
  end

end