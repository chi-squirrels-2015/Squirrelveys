class User < ActiveRecord::Base
  has_many :surveys
  validates :email, uniqueness: true

  def self.authenticate(email, password)
    user = User.find_by(email: email)
    if user && user.password == password
      return user
    end
  end

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end
end
