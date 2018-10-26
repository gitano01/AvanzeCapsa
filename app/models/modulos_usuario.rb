class ModulosUsuario < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :modulo
end
