class VideoComment < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:body]
  pg_search_scope :search, against: [:body]
  belongs_to :video
  validates :body, presence: true
  has_many :replies, dependent: :destroy
  belongs_to :user
end
