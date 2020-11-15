class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.integer :instructor_id
      t.integer :lesson_id
      t.integer :reviewer_id
      t.integer :rating
      t.text :review

      t.timestamps
    end
  end
end
