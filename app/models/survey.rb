class Survey < ActiveRecord::Base
  has_many :questions
  has_many :answers, through: :questions
  has_many :responses
  belongs_to :user

  validates :ref_code, uniqueness: true


  # def response_count(survey_id, answers)
  #   surv = Survey.find(survey_id)
  #   hash_of_answers = {}
  #   surv.responses.each do |response|
  #     hash_of_answers[response.answer.content] +=1
  #   end
  #   hash_of_answers[answer_content]
  # end

  def response_count(survey_id, answers, answer_content)
    unique_answers = answers.uniq
    hash_of_answers = {}
    surv = Survey.find(survey_id)
    surv.responses.each do |response|
      unique_answers.each do |answer|
        hash_of_answers[answer] = answers.count(answer)
      end
    end
    hash_of_answers[answer_content]
  end
end
