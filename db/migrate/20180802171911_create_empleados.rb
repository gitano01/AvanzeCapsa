class CreateEmpleados < ActiveRecord::Migration
  def change
    create_table :empleados do |t|
      t.string :nombre_completo
      t.string :apellido_paterno
      t.string :apellido_materno
      t.string :rfc
      t.date :fecha_nacimiento
      t.date :fecha_registro
      t.string :direccion
      t.string :ciudad
      t.string :estado
      t.string :codigo_postal

      t.timestamps null: false
    end
  end
end
