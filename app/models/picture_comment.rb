class PictureComment < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:body]
  pg_search_scope :search, against: [:body]
  belongs_to :picture
  validates :body, presence: true
  belongs_to :user
end
