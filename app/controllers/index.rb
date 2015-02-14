get '/' do
  # Look in app/views/index.erb
  if current_user
    redirect '/profile'
  end
  erb :index
end

# +++++++++++++++++++++++++++++++ SURVEYS
post '/surveys' do
  @survey = current_user.surveys.build(params[:survey])

  params[:questions].each do |question|
    q = @survey.questions.create(content)
    question.answers.each do |answer|
      q.answers.create(answer)
    end
  end

  if @survey.save
    flash[:notice] = "Survey created successfully!"
    redirect "/#{@survey.ref_code}"
  else
    @errors = @survey.errors
    erb :"surveys/new"
  end
end

get '/surveys/new' do
  if current_user
    erb :"surveys/new"
  else
    flash[:notice] = "You need to sign up or log in before you can create a survey."
    redirect "/signup"
  end
end

get 'surveys/:id/edit' do
  @survey = Survey.find(params[:id])
  if current_user == @survey.owner
    flash[:notice] = "Survey updated!"
    erb :"surveys/edit"
  else
    flash[:notice] = "That doesn't belong to you."
    redirect "/profile"
  end
end

put 'surveys/:id' do
  survey = Survey.find(params[:id])

  survey.update(params[:survey])
end


# +++++++++++++++++++++++++++++++++ USERS
get '/signup' do
  @user = User.new
  erb :'users/new'
end

post '/users' do
  @user = User.new(params[:user])
  if @user.save
    flash[:notice] = "Welcome, thanks for signing up!"
    session[:user_id] = @user.id
    redirect '/profile'
  else
    flash[:notice] = @user.errors.full_messages
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
    erb :'auth/login'
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

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end
# +++++++++++++++++++++++++++++++++++++++ RESPONSES
get '/surveys/:id/responses' do
  survey = Survey.find(params[:id])

  if current_user == survey.owner
    @responses = survey.responses

    erb :"responses/index"
  else
    flash[:notice] = "You don't have access to those responses."
    redirect "/"
  end
end

get '/surveys/:survey_id/responses/:id' do
  response = Response.find(params[:id])

  erb :"responses/show"
end

post '/surveys/:id/responses' do
  @survey = Survey.find_by(ref_code: params[:ref_code])

  params[:answers].each do |answer|
    @survey.responses.create(answer: answer)
  end

  redirect "/finished"
end

get '/finished' do
  erb :"responses/finished"
end

# ++++++++++++++++++++++++++ LAST ROUTE
get '/:ref_code' do
  @survey = Survey.find_by(ref_code: params[:ref_code])
  erb :"responses/show"
end
