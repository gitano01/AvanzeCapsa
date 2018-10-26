class CreateSucursales < ActiveRecord::Migration
  def change
    create_table :sucursales do |t|
      t.string :nombre
      t.string :telefonos
      t.string :iniciales
      t.string :direccion
      t.string :ciudad
      t.string :estado
      t.string :codigo_postal

      t.timestamps null: false
    end
  end
end
