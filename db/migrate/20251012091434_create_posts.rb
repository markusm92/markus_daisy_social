class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :user
      t.string :belongs_to
      t.string :caption
      t.text :body

      t.timestamps
    end
  end
end
