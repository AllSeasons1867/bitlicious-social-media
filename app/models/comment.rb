class Comment < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:body]
  pg_search_scope :search, against: [:body]
  belongs_to :post
  validates :body, presence: true
  belongs_to :user
end

