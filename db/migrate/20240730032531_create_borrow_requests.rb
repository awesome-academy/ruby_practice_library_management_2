class CreateBorrowRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :borrow_requests do |t|
      t.references :user, null: false, foreign_key: true, type: :bigint
      t.references :book, null: false, foreign_key: true, type: :bigint
      t.date :start_date
      t.date :end_date
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
