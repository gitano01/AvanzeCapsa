class CreateUsuarios < ActiveRecord::Migration
  def self.up
    create_table :usuarios do |t|
      t.references :empleado, index: true
      t.references :rol, index: true
      t.string :usuario
      t.string :email
      t.string :tipo
      t.string :contrasena_cifrado

      t.timestamps null: false
    end
    add_foreign_key :usuarios, :empleados
    add_foreign_key :usuarios, :roles
  end
  def self.dowm
    drop_table :usuarios
  end
end
