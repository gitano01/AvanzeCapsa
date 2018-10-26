class Terminal < ActiveRecord::Base
  belongs_to :sucursal
  belongs_to :cajas_registradora
  belongs_to :inventario

  #validates :nombre, uniqueness: { case_sensitive: false }
end
