class AddToExpenses < ActiveRecord::Migration[7.0]
  def change
    add_column :expenses, :author_id, :integer
    add_foreign_key :expenses, :users, column: :author_id
  end
end
