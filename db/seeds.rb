require 'faker'
require 'bcrypt'
#USERS--------
User.create(full_name: "Testy McTester", email: "test@test.com", password: "password", profile_picture: Faker::Avatar.image)
5.times do
  User.create(full_name: Faker::Name.name, email: Faker::Internet.email, password_hash: BCrypt::Password.create("password"), profile_picture: Faker::Avatar.image)
end

#SURVEYS-------
User.all.each do |user|
  rand(5..10).times do
    Survey.create(user: user, survey_name: Faker::Lorem.word )
  end
end

#QUESTIONS------
Survey.all.each do |survey|
  rand(5..20).times do
    Question.create(content: "#{Faker::Lorem.sentence[0..-2]}?", survey: survey)
  end
end

#ANSWERS--------
Question.all.each do |question|
  Answer.create(content: Faker::Lorem.word, question: question)
  Answer.create(content: Faker::Lorem.word, question: question)
  Answer.create(content: Faker::Lorem.word, question: question)
  Answer.create(content: Faker::Lorem.word, question: question)
end

#RESPONSES--------
Survey.all.each do |survey|
  rand(5..10).times do
    survey.questions.each do |question|
      Response.create(survey: survey, answer: question.answers.sample)
    end
  end
end
