# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb

require "faker"

10.times do
  Author.create!(name: Faker::Book.author)
end

10.times do
  Publisher.create!(name: Faker::Book.publisher)
end

10.times do
  Category.create!(name: Faker::Book.genre)
end

authors = Author.all
publishers = Publisher.all
categories = Category.all

50.times do
  Book.create!(
    title: Faker::Book.title,
    description: Faker::Lorem.paragraph,
    author: authors.sample,
    publisher: publishers.sample,
    category: categories.sample,
    published_date: Faker::Date.between(from: '2000-01-01', to: '2024-01-01'),
    rental_price: Faker::Commerce.price(range: 5.0..50.0)
  )
end


