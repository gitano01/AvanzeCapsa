class CajasRegistradorasController < ApplicationController

  before_action :set_caja_registradora, except: [:index, :new, :create]
  before_action :quitarBandera, :definirControlador

  def definirControlador
    @controlador = 'cajas_registradoras'
    @controladorSingular = 'la caja registradora'
  end

  def quitarBandera
    @creacion = false
  end

  def index
    @cajas_registradoras = CajasRegistradora.all
  end

  def new
    @caja_registradora = CajasRegistradora.new
    @creacion = true
  end

  def edit
    @caja_registradora = CajasRegistradora.find(params[:id])
  end

  def create
    @caja_registradora = CajasRegistradora.new(caja_registradora_params)
    if CajasRegistradora.find_by(nombre: params[:cajas_registradora][:nombre]).blank?
      if @caja_registradora.save
        flash[:success] = 'La  Caja registradora fue creada satisfactoriamente'
        redirect_to new_terminal_path
      end
    else
      @creacion = true
      flash[:info] = params[:cajas_registradora][:nombre] + ' ya está registrada en el sistema'
      render :new
    end
  end

  def update
    @caja_registradora = CajasRegistradora.find(params[:id])
    if CajasRegistradora.where('id != ? and nombre = ?', @caja_registradora.id, params[:cajas_registradora][:nombre]).present?
      flash[:info] = params[:cajas_registradora][:nombre] + ' ya está registrada en el sistema'
      render :edit
    else
      if @caja_registradora.update(caja_registradora_params)
        flash[:success] = 'La  Caja registradora fue actualizada  satisfactoriamente'
        redirect_to new_terminal_path
      end
    end
  end

  def destroy
    @caja_registradora.destroy
    redirect_to cajas_registradoras_url
  end

  private
  def caja_registradora_params
    params.require(:cajas_registradora).permit(:nombre, :monto_inicial)
  end

  def set_caja_registradora
    @caja_registradora = CajasRegistradora.find(params[:id])
  end
end
