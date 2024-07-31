class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.references :author, null: false, foreign_key: true, type: :bigint
      t.references :publisher, null: false, foreign_key: true, type: :bigint
      t.references :category, null: false, foreign_key: true, type: :bigint
      t.date :published_date
      t.decimal :rental_price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
