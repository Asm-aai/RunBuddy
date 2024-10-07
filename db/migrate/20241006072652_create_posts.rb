class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.string :title, null: false
      t.text :address, null: false
      t.text :hp, null: false
      t.text :introduction, null: false
      t.references :user, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }

      t.timestamps
    end
    add_index :posts, [:title, :introduction]
  end
end
