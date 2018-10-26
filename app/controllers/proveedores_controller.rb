class ProveedoresController < ApplicationController
  before_action :set_proveedores, except: [:index, :new, :create]
  before_action :definirControlador, :quitarBandera

  def definirControlador
    @controlador = 'proveedores'
    @controladorSingular = 'el proveedor'
  end

  def quitarBandera
    @creacion = false
  end

  def index
    @proveedores = Proveedor.all.order :nombre # proveedor es el modelo
  end

  def show
    @proveedores = Proveedor.find(params[:id])
    redirect_to proveedores_path if @proveedores.nombre == "Proveedor"
  end

  def new
    @proveedores = Proveedor.new
#    @e = @estados.all
    @creacion = true
  end

  def edit
    @proveedores = Proveedor.find(params[:id])
    redirect_to proveedores_path if @proveedores.nombre == "Proveedor"
    @estado= @proveedores.estado
  end

  def create

    @proveedores = Proveedor.new(proveedor_params)
    if @proveedores.save
      flash[:success] = "Proveedor creado exitosamente"
      redirect_to @proveedores
    else
      flash[:error] = "Error al crear proveedor"
      render :new
    end
  end

  def update
    if @proveedores.update(proveedor_params)
      flash[:success] = "Proveedor actualizado exitosamente"
      redirect_to proveedores_path
    else
      flash[:error] = "Error al actualizar proveedor"
      render :edit
    end

  end

  def destroy
    if @proveedores.destroy
      flash[:success] = "Proveedor eliminado exitosamente"
      redirect_to proveedores_path
    else
      flash[:error]= "Error al eliminar proveedor"
    end
  end

  private

  def proveedor_params
    params.require(:proveedor).permit(:nombre, :contacto, :servicio, :rfc, :email, :telefono, :direccion, :ciudad, :estado, :codigo_Postal)
    end

  def set_proveedores
    @proveedores = Proveedor.find(params[:id])
  end
end
