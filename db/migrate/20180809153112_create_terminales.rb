class CreateTerminales < ActiveRecord::Migration
  def change
    create_table :terminales do |t|
      t.references :sucursal, index: true
      t.references :cajas_registradora, index: true
      t.references :inventario, index: true
      t.string :nombre
      t.boolean :caja_registradora_habilitada

      t.timestamps null: false
    end
    add_foreign_key :terminales, :sucursales
    add_foreign_key :terminales, :inventarios
    add_foreign_key :terminales, :cajas_registradoras
  end
end
