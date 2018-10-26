class AddNewValuesToEmpresa < ActiveRecord::Migration
  def change
    add_column :empresas, :iva, :float
  end
end
