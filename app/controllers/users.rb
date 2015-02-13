get '/signup' do
  erb :'users/new'
end

post '/users' do
  @user = User.new(params[:user])
  if @user.save
    flash[:notice] = "Welcome, thanks for signing up!"
    redirect '/profile'
  else
    @errors = @user.errors.full_messages
    erb :'users/new'
  end
end

get '/profile' do
  if current_user
    @surveys = current_user.surveys
    erb :'users/profile'
  else
    flash[:notice] = "You're not authorized to view that page, please sign in!"
    redirect '/'
  end
end

get '/login' do
  if current_user
    redirect '/profile'
  else
    erb: 'users/login'
  end
end

post '/login' do
  user = User.authenticate(params[:email], params[:password])
  if user
    flash[:notice] = "Successfully logged in!"
    session[:user_id] = user.id
    redirect '/profile'
  else
    flash[:notice] = "email password not found"
    redirect '/login'
  end
end

