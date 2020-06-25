class ClassmatesController < ApplicationController
  before do
    login_required
  end

  get '/classmates' do
    @classmates = current_user.classmates
    erb :"/classmates/index"
  end

  get '/classmates/new' do
    @courses = current_user.courses
    erb :"/classmates/new"
  end

  post '/classmates' do
    create_classmate("/classmates", "/classmates/new")
  end

  get '/classmates/:id' do
    permission_required
    erb :"classmates/show"
  end

  get '/classmates/:id/edit' do
    permission_required
    @courses = current_user.courses
    erb :"classmates/edit"
  end

  patch '/classmates/:id' do
    permission_required
    update_classmate("/classmates/#{@classmate.id}", "/classmates/#{@classmate.id}/edit")
  end

  delete '/classmates/:id' do
    permission_required
    @classmate.destroy
    redirect to "/classmates"
  end

  private

  def permission_required
    unless @classmate = current_user.classmates.find_by_id(params[:id])
      flash[:alerts] = ["You don't have permission"]
      redirect to "/classmates"
    end
  end

end