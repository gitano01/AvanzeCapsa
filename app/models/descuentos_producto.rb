class DescuentosProducto < ActiveRecord::Base
  belongs_to :descuento
  belongs_to :producto
end
