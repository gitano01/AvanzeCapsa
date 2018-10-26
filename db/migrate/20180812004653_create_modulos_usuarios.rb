class CreateModulosUsuarios < ActiveRecord::Migration
  def change
    create_table :modulos_usuarios do |t|
      t.references :usuario, index: true
      t.references :modulo, index: true

      t.timestamps null: false
    end
    add_foreign_key :modulos_usuarios, :usuarios
    add_foreign_key :modulos_usuarios, :modulos
  end
end
