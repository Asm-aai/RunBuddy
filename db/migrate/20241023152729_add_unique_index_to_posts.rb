class AddUniqueIndexToPosts < ActiveRecord::Migration[6.1]
  def change
    add_index :posts, [:address, :hp], unique: true, name: 'index_posts_on_address_and_hp_unique', length: { address: 255 }
  end
end
