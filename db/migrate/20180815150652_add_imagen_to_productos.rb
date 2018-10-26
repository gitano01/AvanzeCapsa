class AddImagenToProductos < ActiveRecord::Migration
  def change
    add_attachment :productos, :imagen
  end
end
