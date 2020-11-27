class CreateReplies < ActiveRecord::Migration[6.0]
  def change
    create_table :replies do |t|
      t.text :body
      t.references :video_comment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
