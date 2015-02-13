class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :answers
  has_many :responses, through: :answers
end
