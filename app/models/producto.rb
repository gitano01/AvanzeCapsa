class Producto < ActiveRecord::Base
  belongs_to :unidad
  has_and_belongs_to_many :categorias
  has_many :descuentos_productos
  has_many :descuentos, through: :descuentos_productos
  has_attached_file :imagen, styles: { medium: "200x200>", thumb: "200x200>" }, default_url: "/images/:style/missing.png", validate_media_type: false
  validates_attachment_content_type :imagen, content_type: /\Aimage\/.*\Z/
end
