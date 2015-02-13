# params[:questions] = {
#   {
#    content: "What is the color of the sky?",
#    answers: [{content: "blue"}, {content: "red"}, {content: "green"}]
#   }
# }

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
