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

  post '/films' do
    if params["film"]["title"] == "" || params["film"]["genre"] == "" || params["film"]["runtime"] == "" || params["film"]["writer_ids"] == nil || params["film"]["director_ids"] == nil
      redirect "/films/new"
    else
      @film = Film.create(params["film"])
      @film.save
      redirect "films/#{@film.id}"
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

  get '/films/:id/edit' do
    if logged_in?
      @film = Film.find_by_id(params[:id])
      if @film.writers.any? { |writer| writer.user_id == current_user.id } || @film.directors.any? { |director| director.user_id == current_user.id}
        erb :'films/edit_film'
      else
        redirect '/films'
      end
    else
      redirect '/login'
    end
  end

  patch '/films/:id' do
    if params["film"]["title"] == "" || params["film"]["genre"] == "" || params["film"]["runtime"] == "" || params["film"]["writer_ids"] == nil || params["film"]["director_ids"] == nil
      redirect "films/#{params[:id]}/edit"
    else
      @film = Film.find_by_id(params[:id])
      @film.update(params["film"])
      @film.save
      redirect "/films/#{@film.id}"
    end
  end

  delete '/films/:id/delete' do
    if logged_in?
      @film = Film.find_by_id(params[:id])
      if @film.writers.any? { |writer| writer.user_id == current_user.id } || @film.directors.any? { |director| director.user_id == current_user.id}
        @film.destroy
        redirect '/films'
      else
        redirect '/films'
      end
    else
      redirect '/login'
    end
  end

end
