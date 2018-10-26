class PermisosController < ApplicationController

	def mod_usuarios
		@usuarios = Usuario.all
	end

	def mod_usuarios_rest
		@usuario = Usuario.find(params[:id])
		@empleado = Empleado.find(@usuario.empleado_id)
		@modulos = Modulo.all
	end

	def guardar_cambios
		if params[:commit] == nil
			render :mod_usuarios
		else
			@usuario = Usuario.find(params[:id])
			@empleado = Empleado.find(@usuario.empleado_id)
			@modulos = Modulo.all
			@usuario.modulos.clear
			for m in @modulos
				if params["#{m.nombre_controlador}"] == "1"
					@usuario.modulos << m unless @usuario.modulos.include? m
				end
			end
			render :show_modulos
		end
	end

	def show_modulos
		@usuario = Usuario.find(params[:id])
		@empleado = Empleado.find(@usuario.empleado_id)
		@modulos = Modulo.all
	end

end
