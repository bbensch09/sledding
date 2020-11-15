class AddRequesterNametoLessons < ActiveRecord::Migration[6.0]
  def change
        add_column :lessons, :requester_name, :string
  end
end
