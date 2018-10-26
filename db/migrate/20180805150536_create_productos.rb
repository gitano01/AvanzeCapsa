class CreateProductos < ActiveRecord::Migration
  def change
    create_table :productos do |t|
      t.string :nombre
      t.string :definicion
      t.string :codigo
      t.string :lugar
      t.float :precio
      t.float :precio_costo
      t.boolean :iva
      t.boolean :disponible_en_inventario
      t.boolean :kit
      t.references :unidad, index: true
      t.timestamps null: false
    end
    #add_foreign_key :productos, :unidades
  end
end
