class AddUserToVideoComment < ActiveRecord::Migration[6.0]
  def change
    add_reference :video_comments, :user, foreign_key: true
  end
end
