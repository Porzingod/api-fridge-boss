# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
jason = User.create(username: "jason", password: "jason")
i1 = Ingredient.create(name: "tortillas", expiration_date: Time.new(2018, 05, 20), user_id: jason.id)
i2 = Ingredient.create(name: "hummus", expiration_date: Time.new(2018, 05, 15), user_id: jason.id)
i3 = Ingredient.create(name: "chicken thighs", expiration_date: Time.new(2018, 05, 10), user_id: jason.id)
i4 = Ingredient.create(name: "bell peppers", expiration_date: Time.new(2018, 05, 25), user_id: jason.id)
i5 = Ingredient.create(name: "pickles", expiration_date: Time.new(2018, 05, 30), user_id: jason.id)
i6 = Ingredient.create(name: "canned tuna", expiration_date: Time.new(2018, 05, 23), user_id: jason.id)

cuisines = ["American", "Italian", "Asian", "Mexican", "Southern & Soul Food", "French", "Southwestern", "Barbecue", "Indian", "Chinese", "Cajun & Creole", "English", "Mediterranean", "Greek", "Spanish", "German", "Thai", "Moroccan", "Irish", "Japanese", "Cuban", "Hawaiian", "Swedish", "Hungarian", "Portugese"]

cuisines.each {|cuisine| Cuisine.create(name: cuisine)}
