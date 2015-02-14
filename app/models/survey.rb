class Survey < ActiveRecord::Base
  has_many :questions
  has_many :answers, through: :questions
  has_many :responses
  belongs_to :user

  validates :ref_code, uniqueness: true


  # def response_count(survey_id)
  #   surv = Survey.find(survey_id)
  #   hash_of_answers = {}
  #   surv.responses.each do |response|
  #     hash_of_answers[response.answer.content] = +=1
  #   end
  #   hash_of_answers
  # end

  def response_count(survey_id, answer_id)
    surv = Survey.find(survey_id)
    count = 0
    array_count = surv.responses.select {|response| response.answer_id = answer_id}
    array_count.length
  end
end
