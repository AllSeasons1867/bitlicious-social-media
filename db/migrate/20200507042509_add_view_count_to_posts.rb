class AddViewCountToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column(:posts, :view_count, :integer)
  end
end
