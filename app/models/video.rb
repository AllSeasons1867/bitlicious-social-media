class Video < ApplicationRecord
    include PgSearch::Model
    multisearchable against: [:title, :description]
    pg_search_scope :search, against: [:title, :description]
    has_one_attached :clip
    belongs_to :user
    has_one_attached :thumbnail
    has_many :video_comments, dependent: :destroy
    validates(:view_count, numericality: {
        greater_than_or_equal_to: 0
    })
    before_validation :set_default_view_count
    private
    def set_default_view_count
        self.view_count ||= 0
    end
end
