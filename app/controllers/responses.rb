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

get '/:ref_code' do
  @survey = Survey.find_by(ref_code: params[:ref_code])
  erb :"responses/show"
end
