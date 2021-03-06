class UsersController < ApplicationController
    get '/signup' do
        if Helpers.is_logged_in?(session)
            redirect '/'
        else 
            erb :'/users/signup'
        end 
    end 

    post '/signup' do 
        user = User.new_with_validations(params)
        if user.save
            session[:user_id] = user.id
            redirect '/profile'
        else
            erb :'/users/signup'
        end
    end 

    get '/login' do
        erb :'/users/login'
    end 

    post '/login' do 
        @user = User.find_by(:username => params[:username])

        if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
            redirect to '/profile'
        else
            redirect to '/login'
		end
    end 

    get '/logout' do 
        if Helpers.is_logged_in?(session)
            session.clear
            redirect '/login'
        else
            redirect '/'
        end
    end 

    get '/profile' do
        if Helpers.is_logged_in?(session)
            @user = User.find(session[:user_id])
            erb :'/users/profile'
        else
            redirect '/login'
        end
    end 
end