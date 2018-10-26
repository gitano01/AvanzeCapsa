class CreateProveedores < ActiveRecord::Migration
  def change
    create_table :proveedores do |t|
      t.string :nombre
      t.string :contacto
      t.string :servicio
      t.string :rfc
      t.string :email
      t.string :telefono
      t.string :direccion
      t.string :ciudad
      t.string :estado
      t.string :codigo_Postal

      t.timestamps null: false
    end
  end
end
