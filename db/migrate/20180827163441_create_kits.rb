class CreateKits < ActiveRecord::Migration
  def change
    create_table :kits do |t|
      t.integer :producto_padre_id
      t.integer :producto_id
      t.integer :cantidad
      t.timestamps null: false
    end
  end
end
