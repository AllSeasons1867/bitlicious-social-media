class Picture < ApplicationRecord
    include PgSearch::Model
    multisearchable against: [:title, :description]
    pg_search_scope :search, against: [:title, :description]
    has_one_attached :picture
    has_many :picture_comments, dependent: :destroy
    belongs_to :user
end
