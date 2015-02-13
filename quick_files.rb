files = ["user", "question", "survey", "answer", "response"]

files.each do |file|
  plural = "create_#{file}s"
  system("bundle exec rake generate:migration NAME=#{plural}")
  system("bundle exec rake generate:model NAME=#{file}")
  # system÷("touch app/controllers/#{file}.rb")
end

