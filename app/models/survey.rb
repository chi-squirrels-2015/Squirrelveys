class Survey < ActiveRecord::Base
  has_many :questions
  has_many :answers, through: :questions
  has_many :responses
  belongs_to :user

  validates :ref_code, uniqueness: true
  
end
