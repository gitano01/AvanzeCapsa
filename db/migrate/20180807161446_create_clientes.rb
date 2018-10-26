class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string :nombre
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
