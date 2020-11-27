class Post < ApplicationRecord
    include PgSearch::Model
    multisearchable against: [:title, :body]
    pg_search_scope :search, against: [:title, :body]

    validates(:title, presence: true)

    belongs_to :user

    has_many :comments, dependent: :destroy

    validates(
        :body,
        presence: {
            message: "Message body must be present."
        },
        length: {
            minimum: 10,
            maximum: 5000
        }
    )

    validates(
        :view_count,
        numericality: {
            greater_than_or_equal_to: 0
        }
    )

    validates(
        :like_count,
        numericality: {
            greater_than_or_equal_to: 0
        }
    )

    before_validation :set_default_like_count
    before_validation :set_default_view_count

    private 

    def set_default_view_count
        self.view_count ||= 0
    end 

    def set_default_like_count
        self.like_count ||= 0
    end 

end


