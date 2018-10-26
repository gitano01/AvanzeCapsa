class ClientesController < ApplicationController
  before_action :set_clientes, except: [:index, :new, :create]
  before_action :definirControlador, :quitarBandera

  def definirControlador
    @controlador = 'clientes'
    @controladorSingular = 'el cliente'
  end

  def quitarBandera
    @creacion = false
  end

  def index
    @clientes = Cliente.all.order :nombre
  end

  def show
    @clientes = Cliente.find(params[:id])
  end
  def new
    @clientes = Cliente.new
    @creacion = true
  end

  def edit
    @clientes = Cliente.find(params[:id])

    @estado = @clientes.estado
  end

  def create
    @clientes = Cliente.new(cliente_params)
    if Cliente.find_by(nombre: params[:cliente][:nombre]).blank?
      if @clientes.save
        flash[:success] = "Cliente creado exitosamente"
        redirect_to @clientes
      else
        flash[:error] = "Error al crear cliente"
        render :new
      end
    else
      @creacion = true
      flash[:info] = 'El cliente: ' + params[:cliente][:nombre] + ' ya está registrado en el sistema'
      render :new
    end
  end

  def update
    if Cliente.where('id != ? and nombre = ?', params[:id], params[:cliente][:nombre]).present?
      @clientes = Cliente.find(params[:id])
      @estado = @clientes.estado
      flash[:info] = 'El cliente: ' + params[:cliente][:nombre] + ' ya está registrado en el sistema'
      render :edit
    else
      if @clientes.update(cliente_params)
        flash[:success] = "Cliente actualizado exitosamente"
        redirect_to clientes_path
      else
        flash[:error] = "Error al actualizar cliente"
        render :edit
      end
    end
  end

  def destroy
    if@clientes.destroy
      flash[:success] = "Cliente Eliminado exitosamente"
      redirect_to clientes_path
    else
      flash[:error]= "Error al eliminar cliente"
    end

  end

  private

  def cliente_params
    params.require(:cliente).permit(:nombre,:rfc, :email, :telefono, :direccion, :ciudad, :estado, :codigo_Postal)
  end

  def set_clientes
    @clientes = Cliente.find(params[:id])
  end
end
