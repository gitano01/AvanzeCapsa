class CreateDescuentos < ActiveRecord::Migration
  def change
    create_table :descuentos do |t|
      t.references :usuario, index: true
      t.references :terminal, index: true
      t.string :nombre
      t.integer :monto
      t.date :fecha_inicial
      t.date :fecha_final

      t.timestamps null: false
    end
    add_foreign_key :descuentos, :usuarios
    add_foreign_key :descuentos, :terminales
  end
end
