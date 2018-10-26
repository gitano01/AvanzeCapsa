class CreateModulos < ActiveRecord::Migration
  def change
    create_table :modulos do |t|
      t.string :nombre_controlador
      t.string :nombre

      t.timestamps null: false
    end
  end
end
