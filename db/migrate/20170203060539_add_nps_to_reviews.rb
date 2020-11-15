class AddNpsToReviews < ActiveRecord::Migration[6.0]
  def change
        add_column :reviews, :nps, :integer
  end
end
