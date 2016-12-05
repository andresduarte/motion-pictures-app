require 'rack-flash'

class FilmsController < ApplicationController

  use Rack::Flash

  get '/films' do
    if logged_in?
      @films = Film.all
      erb :'films/films'
    else
      redirect '/Login'
    end
  end

  get '/films/new' do
    if logged_in?
      erb :'films/create_film'
    else
      redirect 'login'
    end
  end

  get '/films/:slug' do
    if logged_in?
      @film = Film.find_by_slug(params[:slug])
      erb :'films/show_film'
    else
      redirect '/login'
    end
  end

  post '/films' do
    if params["film"]["title"] == "" || params["film"]["genre"] == "" || params["film"]["runtime"] == "" || params["film"]["writer_ids"] == nil || params["film"]["director_ids"] == nil
      flash[:message] = "Please fill all fields to create film"
      redirect "/films/new"
    else
      @film = Film.create(params["film"])
      @film.save
      flash[:message] = "Successfully created film"
      redirect "films/#{@film.slug}"
    end
  end

  get '/films/:slug/edit' do
    if logged_in?
      @film = Film.find_by_slug(params[:slug])
      if @film.writers.any? { |writer| writer.user_id == current_user.id } || @film.directors.any? { |director| director.user_id == current_user.id}
        erb :'films/edit_film'
      else
        flash[:message] = "You can't edit a film you didn't write or direct"
        redirect '/films'
      end
    else
      redirect '/login'
    end
  end

  patch '/films/:slug' do
    if params["film"]["title"] == "" || params["film"]["genre"] == "" || params["film"]["runtime"] == "" || params["film"]["writer_ids"] == nil || params["film"]["director_ids"] == nil
      flash[:message] = "Please fill all fields to edit film"
      redirect "films/#{params[:slug]}/edit"
    else
      @film = Film.find_by_slug(params[:slug])
      @film.update(params["film"])
      @film.save
      flash[:message] = "Successfully updated song."
      redirect "/films/#{@film.slug}"
    end
  end

  delete '/films/:slug/delete' do
    if logged_in?
      @film = Film.find_by_slug(params[:slug])
      if @film.writers.any? { |writer| writer.user_id == current_user.id } || @film.directors.any? { |director| director.user_id == current_user.id}
        @film.destroy
        flash[:message] = "Successfully deleted film"
        redirect '/films'
      else
        flash[:message] = "You can't delete a film you didn't write or direct"
        redirect '/films'
      end
    else
      redirect '/login'
    end
  end

end
