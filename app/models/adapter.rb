class Adapter

  YUMMLY_ID_AND_KEY = "?_app_id=#{ENV["YUMMLY_APP_ID"]}&_app_key=#{ENV["YUMMLY_APP_KEY"]}"

  YUMMLY_RECIPES_URL = "http://api.yummly.com/v1/api/recipes"
  YUMMLY_GET_RECIPE_URL = "http://api.yummly.com/v1/api/recipe/"

  ALLOWED_INGR = "&allowedIngredient[]="
  ALLOWED_HOLIDAY = "&allowedHoliday[]=holiday^holiday-"
  yummlyHolidays = ["Christmas", "Summer", "Thanksgiving", "New+Year", "Super+Bowl", "Game+Day", "Halloween", "Hanukkah", "4th+of+July"]
  NEAREST_HOLIDAY = yummlyHolidays[1]

  def self.yummly_id_key
    "?_app_id=#{ENV["YUMMLY_APP_ID"]}&_app_key=#{ENV["YUMMLY_APP_KEY"]}"
  end

  def self.recipes_url
    "http://api.yummly.com/v1/api/recipes"
  end

  def self.find_recipe_url
    "http://api.yummly.com/v1/api/recipe/"
  end

  def self.allow_ingredient
    "&allowedIngredient[]="
  end

  def self.allow_holiday
    "&allowedHoliday[]=holiday^holiday-"
  end

  def self.holiday
    yummlyHolidays = ["Christmas", "Summer", "Thanksgiving", "New+Year", "Super+Bowl", "Game+Day", "Halloween", "Hanukkah", "4th+of+July"]
    yummlyHolidays[1]
  end

end
