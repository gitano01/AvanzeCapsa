class InventariosController < ApplicationController
  before_action :set_inventario, except: [:index, :new, :create]
  before_action :definirControlador, :quitarBandera

  def definirControlador
    @controlador = 'inventarios'
    @controladorSingular = 'el inventario'
  end

  def quitarBandera
    @creacion = false
  end

  def index
    @inventarios = Inventario.all.order :nombre
  end

  def new
    @inventario = Inventario.new
    @creacion = true
  end

  def show
  end

  def create
    @inventario = Inventario.new(inventario_params)
    if Inventario.find_by(nombre: params[:inventario][:nombre]).blank?
      if @inventario.save
        flash[:success] = "Inventario creado exitosamente"
        redirect_to inventarios_path
      else
        flash.now[:danger] = @inventario.errors.full_messages.to_sentence
        render :new
      end
    else
      @creacion = true
      flash[:info] = params[:inventario][:nombre] + ' ya está registrado en el sistema'
      render :new
    end
  end

  def edit
  end

  def update
    if Inventario.where('id != ? and nombre = ?', @inventario.id, params[:inventario][:nombre]).present?
      flash[:info] = params[:inventario][:nombre] + ' ya está registrado en el sistema'
      render :edit
    else
      if @inventario.update(inventario_params)
        flash[:success] = "Inventario actualizado exitosamente"
        redirect_to inventarios_path
      else
        render :edit
      end
    end
  end

  def destroy
    @inventario.destroy
    flash[:success] = "Inventario eliminado exitosamente."
    redirect_to inventarios_path
  end

  private
  def inventario_params
    params.require(:inventario).permit(:nombre)
  end

  def set_inventario
    @inventario = Inventario.find(params[:id])
  end
end
