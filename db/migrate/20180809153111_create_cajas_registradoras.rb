class CreateCajasRegistradoras < ActiveRecord::Migration
  def change
    create_table :cajas_registradoras do |t|
      t.string :nombre
      t.decimal :monto_inicial

      t.timestamps null: false
    end
  end
end
