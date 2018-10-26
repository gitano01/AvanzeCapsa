class Empresa < ActiveRecord::Base

   has_attached_file :imagen, styles: { medium: "200x200>", thumb: "200x200>" }, default_url: "/images/:style/missing.png", validate_media_type: false

validates_attachment_content_type :imagen, content_type: /\Aimage\/.*\Z/

end
