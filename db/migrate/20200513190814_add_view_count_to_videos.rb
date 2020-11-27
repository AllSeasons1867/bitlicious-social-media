class AddViewCountToVideos < ActiveRecord::Migration[6.0]
  def change
    add_column(:videos, :view_count, :integer)
  end
end
