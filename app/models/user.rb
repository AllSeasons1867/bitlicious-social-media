class User < ApplicationRecord
    has_secure_password
    validates :name, presence: true
    VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    validates(:email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX)
    has_many :comments, dependent: :nullify
    has_many :pictures, dependent: :nullify
    has_many :posts, dependent: :nullify
    has_many :replies, dependent: :nullify
    has_many :stories, dependent: :nullify
    has_many :video_comments, dependent: :nullify
    has_many :videos, dependent: :nullify
    has_many :picture_comments, dependent: :nullify
    has_many :story_comments, dependent: :nullify
    def full_name
        name
    end
end
