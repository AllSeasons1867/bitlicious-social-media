class AddUserToPictureComment < ActiveRecord::Migration[6.0]
  def change
    add_reference :picture_comments, :user, foreign_key: true
  end
end
