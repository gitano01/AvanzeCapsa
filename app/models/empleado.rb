class Empleado < ActiveRecord::Base
	has_many :usuarios, dependent: :destroy
end
