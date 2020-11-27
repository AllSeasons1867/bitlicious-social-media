class AddUserToStoryComment < ActiveRecord::Migration[6.0]
  def change
    add_reference :story_comments, :user, foreign_key: true
  end
end
