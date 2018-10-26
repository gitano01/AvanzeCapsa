class Descuento < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :terminal
  belongs_to :categoria
  has_many :descuentos_productos
  has_many :descuentos_productos, dependent: :destroy
  has_many :productos, through: :descuentos_productos
end
