class AddColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :company_id, :string
    add_column :users, :role, :integer, default: 1
  end
end
