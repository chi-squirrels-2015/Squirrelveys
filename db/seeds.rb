require 'faker'
require 'bcrypt'
#USERS--------
5.times do
  User.create(full_name: Faker::Name.name, email: Faker::Internet.email, password_hash: BCrypt::Password.create("password"), profile_picture: Faker::Avatar.image)
end

#SURVEYS-------
User.all.each do |user|
  Survey.create(survey_name: Faker::Lorem.word, ref_code: "#{rand(100000..999999)}", user_id: user.id )
end

#QUESTIONS------
Survey.all.each do |survey|
  Question.create(content: "#{Faker::Lorem.sentence}?", survey_id: survey.id)
  Question.create(content: "#{Faker::Lorem.sentence}?", survey_id: survey.id)
end

#ANSWERS--------
Question.all.each do |question|
  Answer.create(content: Faker::Lorem.word, question_id: question.id)
  Answer.create(content: Faker::Lorem.word, question_id: question.id)
  Answer.create(content: Faker::Lorem.word, question_id: question.id)
  Answer.create(content: Faker::Lorem.word, question_id: question.id)
end  

#RESPONSES--------
Survey.all.each do |survey|
  Response.create(survey_id: survey.id, answer_id: survey.answers.sample.id)
  Response.create(survey_id: survey.id, answer_id: survey.answers.sample.id)
  Response.create(survey_id: survey.id, answer_id: survey.answers.sample.id)
  Response.create(survey_id: survey.id, answer_id: survey.answers.sample.id)
  Response.create(survey_id: survey.id, answer_id: survey.answers.sample.id)
end
