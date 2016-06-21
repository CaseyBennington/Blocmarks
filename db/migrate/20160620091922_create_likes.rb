class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :bookmark, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    # add_foreign_key :likes, :bookmarks
    # add_foreign_key :likes, :users
  end
end
