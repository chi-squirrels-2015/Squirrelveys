class Survey < ActiveRecord::Base
  before_create :generate_ref_code

  has_many :questions
  has_many :answers, through: :questions
  has_many :responses
  belongs_to :user

  validates :ref_code, uniqueness: true

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

  private

  def generate_ref_code
    self.ref_code = rand(36**10).to_s(36)
  end
end