class AddImagenToEmpresa < ActiveRecord::Migration
  def change
    add_attachment :empresas, :imagen
  end
end
