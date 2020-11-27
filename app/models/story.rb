class Story < ApplicationRecord
    include PgSearch::Model
    multisearchable against: [:title, :body]
    pg_search_scope :search, against: [:title, :body]
    validates(:title, presence: true)
    validates(:body, presence: {message: "Must be present!"}, length: {minimum: 10})
    validates(:view_count, numericality: {greater_than_or_equal_to: 0})
    has_many :story_comments, dependent: :destroy
    belongs_to :user
    before_validation :set_default_view_count
    private
    def set_default_view_count
        self.view_count ||= 0
    end
end
