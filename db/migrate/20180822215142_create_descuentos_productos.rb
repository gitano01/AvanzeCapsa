class CreateDescuentosProductos < ActiveRecord::Migration
  def change
    create_table :descuentos_productos do |t|
      t.references :descuento, index: true
      t.references :producto, index: true

      t.timestamps null: false
    end
    add_foreign_key :descuentos_productos, :descuentos
    add_foreign_key :descuentos_productos, :productos
  end
end
