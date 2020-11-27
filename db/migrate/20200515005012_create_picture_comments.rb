class CreatePictureComments < ActiveRecord::Migration[6.0]
  def change
    create_table :picture_comments do |t|
      t.text :body
      t.references :picture, null: false, foreign_key: true

      t.timestamps
    end
  end
end
