class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
    t.string :recipeName
    t.string :recipeId
    t.string :ingredients
    t.string :smallImageUrls
    t.integer :totalTimeInSeconds
    end
  end
end
