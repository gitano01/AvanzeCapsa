class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #devise :database_authenticatable, :registerable,
   #      :recoverable, :rememberable, :validatable
  belongs_to :empleado
  belongs_to :rol
  has_many :modulos_usuarios, dependent: :destroy
  has_many :modulos, through: :modulos_usuarios
  
end
