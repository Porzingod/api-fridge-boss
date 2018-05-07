class IngredientSerializer < ActiveModel::Serializer
  attributes :id, :name, :expiration_date
end
