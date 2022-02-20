class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies, id: :string do |t|
      t.string      :name
      t.timestamps
    end
  end
end
