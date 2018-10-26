class EmpleadosController < ApplicationController
	
	before_action :set_empleado, only: [:show, :edit, :update, :destroy]
	before_action :definirControlador, :quitarBandera

	def index
		@empleados = Empleado.all
	end

	def show
	end

	def new
		@empleado = Empleado.new 
		@usuario = Usuario.new
		@roles = Rol.all
		@creacion = true

		@rol = 1
	end

	def edit
		@roles = Rol.all
		@usuario = Usuario.find_by(empleado_id: params[:id])
		@rol = @usuario.rol_id
		@estado = @usuario.empleado.estado
	end

	def create
		@empleado = Empleado.new(empleado_params)
		if Usuario.find_by(usuario: params[:usuario][:usuario]).blank?
			@usuario = @empleado.usuarios.new(usuario_params)
			begin
				Empleado.transaction do
					@empleado.save
					Usuario.transaction do
						@usuario.save
          #  @user.save
						flash[:success] = 'El Usuario-Empleado ha sido creado satisfactoriamente'
						redirect_to @empleado
					end
				end
			rescue
				#message
			end
		else
			@roles = Rol.all
			@creacion = true
			@rol = params[:usuario][:rol_id].to_i
			@usuario = Usuario.new(usuario_params)
			flash[:info] = 'El usuario: ' + @usuario.usuario + ' ya está registrado en el sistema'
			render :new
		end
	end

	def actualiza
		@empleado = Empleado.find(params[:id])
		@usuario = Usuario.find_by(empleado_id: @empleado.id)
		if Usuario.where('id != ? and usuario = ?', @usuario.id, params[:usuario][:usuario]).present?
			@roles = Rol.all
			@rol = params[:usuario][:rol_id].to_i
	    	flash[:info] = 'El usuario: ' + params[:usuario][:usuario] + ' ya está registrado en el sistema'
	    	render :edit
		else
			begin
				Empleado.transaction do
					@empleado.update(empleado_params)
					Usuario.transaction do
						@usuario.update(usuario_params)
						@user = @usuario
						flash[:success] = "El Empleado ha sido actualizado satisfactoriamente"
						redirect_to @empleado
					end
				end
			rescue
				#message
			end
		end
	end

	def destroy
	    @empleado.destroy
	    flash[:success] = "El Empleado ha sido eliminado satisfactoriamente"
	    redirect_to empleados_url
	end

	def definirControlador
		@controlador = 'empleados'
		@controladorSingular = 'el empleado'
	end

	def quitarBandera
		@creacion = false
	end

	private
	
	def set_empleado
		@empleado = Empleado.find(params[:id])
	end

	def empleado_params
		params.require(:empleado).permit(:nombre_completo, :apellido_paterno, :apellido_materno, :rfc, 
			:fecha_nacimiento, :fecha_registro, :direccion, :ciudad, :estado, :codigo_postal)
	end

	def usuario_params
		params.require(:usuario).permit(:rol_id, :usuario, :email,:tipo, :contrasena_cifrado)
  end


end

