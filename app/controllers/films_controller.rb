class FilmsController < ApplicationController

  get '/films' do
    if logged_in?
      @films = Film.all.uniq
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

  get '/films/:id' do
    if logged_in?
      @film = Film.find_by_id(params[:id])
      erb :'films/show_film'
    else
      redirect '/login'
    end
  end

  get '/films/:id/delete' do
    if logged_in?
      @film = Film.find_by_id(params[:id])
      if @film.writers.any? { |writer| writer.user_id == current_user.id } || @film.directors.any? { |director| director.user_id == current_user.id}
        @film.delete
        redirect '/films'
      else
        redirect '/films'
      end
    else
      redirect '/login'
    end
  end


end
