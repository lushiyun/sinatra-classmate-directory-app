class ClassmatesController < ApplicationController
  before do
    login_required
  end

  get '/classmates' do
    @classmates = current_user.classmates
    erb :"/classmates/index"
  end

  get '/classmates/new' do
    erb :"/classmates/new"
  end

  # TODO
  post '/classmates' do
    classmate = Classmate.new(params)
    if classmate.valid?
      classmate.user = current_user
      classmate.save
    else 
      flash[:alerts] = classmate.errors.full_messages
      redirect to "/classmates/new"
    end
  end

  get '/classmates/:id' do
    if authorized_for_classmate
      erb :"classmates/show"
    else 
      classmate_unauthorized
    end
  end

  get '/classmates/:id/edit' do
    if authorized_for_classmate
      erb :"classmates/edit"
    else 
      classmate_unauthorized
    end 
  end

  patch '/classmates/:id' do
    classmate = current_user.classmates.find_by(id: params[:id])
    if classmate.update(params)
      redirect to "/classmates/#{classmate.id}"
    else 
      flash[:alerts] = classmate.errors.full_messages
      redirect to "/classmates/#{classmate.id}/edit"
    end
  end

  delete '/classmates/:id' do
    classmate = Classmate.find_by(id: params[:id])
    current_user.classmates.destroy(classmate)
  end
end