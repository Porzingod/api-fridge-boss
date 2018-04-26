class CreateRecipeIngredientJoins < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_ingredient_joins do |t|
      t.references :recipe, foreign_key: true
      t.references :recipe_ingredient, foreign_key: true
      t.timestamps
    end
  end
end
