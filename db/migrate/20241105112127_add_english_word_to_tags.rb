class AddEnglishWordToTags < ActiveRecord::Migration[6.1]
  def change
    add_column :tags, :english_word, :string
    add_index :tags, :english_word, length: 255
  end
end
