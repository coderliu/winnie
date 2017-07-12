class AddIncludeEnglishToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :include_english, :boolean, default: false
  end
end
