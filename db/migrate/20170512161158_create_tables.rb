class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :shoes do |t|
      t.column :name, :string
      t.column :cost, :string
      t.column :description, :string
    end
    create_table :stores do |t|
      t.column :name, :string
      t.column :description, :string
    end
  end
end
