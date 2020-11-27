class AddViewCountToStories < ActiveRecord::Migration[6.0]
  def change
    add_column(:stories, :view_count, :integer)
  end
end
