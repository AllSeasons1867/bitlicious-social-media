class Reply < ApplicationRecord
  belongs_to :video_comment
  validates :body, presence: true
  belongs_to :user
end
