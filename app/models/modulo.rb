class Modulo < ActiveRecord::Base
	has_many :usuarios, through: :modulos_usuarios
end
