class CreateCategoriasProductosJoin < ActiveRecord::Migration
  def change
    create_table :categorias_productos, :id => false do |t|
      t.integer   :categoria_id
      t.integer   :producto_id
    end
  end
end
