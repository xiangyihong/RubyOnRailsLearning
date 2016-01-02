class User < ActiveRecord::Base
  USER_NAME_MAX_LENGTH = 50
  USER_EMAIL_MAX_LENGTH = 255
  USER_EMAIL_NAME_MINIMUM_LENGTH = 3

  VALID_EMAIL_REGEX = /\A[\w+\-.]{#{USER_EMAIL_NAME_MINIMUM_LENGTH},}@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: { maximum: USER_NAME_MAX_LENGTH }
  validates :email, presence: true,
                    length: { maximum: USER_EMAIL_MAX_LENGTH },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: {case_sensitive: false}

end
