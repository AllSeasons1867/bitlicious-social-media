class CreateStoryComments < ActiveRecord::Migration[6.0]
  def change
    create_table :story_comments do |t|
      t.text :body
      t.references :story, null: false, foreign_key: true

      t.timestamps
    end
  end
end
