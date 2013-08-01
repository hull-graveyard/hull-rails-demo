class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to  :user,      null: false
      t.string      :title,     null: false
      t.string      :content,   null: false
      t.timestamps
    end
  end
end
