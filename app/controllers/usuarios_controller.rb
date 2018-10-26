class UsuariosController < ApplicationController
	
	def index
		@usuarios = Usuario.all
	end

	def show
	end

	def new
		@usuario = Usuario.new
	end

	def edit
	end

	def create
		@usuario = Usuario.new(usuario_params)

		if @usuario.save
			redirect_to @usuario
		else
			render :new
		end
	end

	def update
		if @usuario.update(usuario_params)
			redirect_to @usuario
		else
			render :edit
		end
	end

	def destroy
		@usuario.destroy
		redirect_to usuarios_url	
	end

	private
	
	def set_usuario
		@usuario = Usuario.find(params[:id])
	end

	def usuario_params
		params.require(:usuario).permit(:usuario, :email,:tipo, :contrasena_cifrada)
	end

end
