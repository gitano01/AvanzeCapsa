class SucursalesController < ApplicationController
  before_action :set_sucursal, except: [:index, :new, :create]
  before_action :quitarBandera, :definirControlador


  def definirControlador
    @controlador = 'sucursales'
    @controladorSingular = 'la sucursal'
  end

  def quitarBandera
    @creacion = false
  end

  # GET/sucursales
  # función indice que se carga al iniciar la aplicación
  def index
    @sucursales = Sucursal.all.order :nombre
  end

  #método nuevo para la creación de una  nueva sucursal
  def new
    @sucursal = Sucursal.new
    @creacion = true
  end

  #método para la visualización de las sucursales
  def show
    @sucursal = Sucursal.find(params[:id])
  end

  #método para la creación ed una nueva sucursal
  def create
    @sucursal = Sucursal.new(sucursal_params)
    if @sucursal.save
      flash[:success] ="Sucursal creada exitosamente"
      redirect_to sucursales_path
    else
      flash[:danger] = @sucursal.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @estado = @sucursal.estado
  end

  def update
    if @sucursal.update(sucursal_params)
      flash[:success] = "Sucursal actualizada exitosamente"
      redirect_to @sucursal
    else
      render :edit
    end
  end

  def destroy
    @sucursal.destroy
    flash[:success] = "Sucursal eliminada exitosamente."
    redirect_to sucursales_path
  end
  private
  def sucursal_params
    params.require(:sucursal).permit(:nombre, :telefonos, :iniciales, :direccion, :ciudad, :estado, :codigo_postal)
  end

  def set_sucursal
    @sucursal = Sucursal.find(params[:id])
  end
end
