class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :comment, null: false
      t.string :total_star, null: false
      t.string :extent_star, null: false
      t.string :clean_star, null: false
      t.string :amenity_star, null: false
      t.string :safety_star, null: false
      t.string :cost_star, null: false

      t.references :user, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :post, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }

      t.timestamps
    end
  end
end
