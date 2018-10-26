class TiposPagosController < ApplicationController
  before_action :set_tipopagos, except: [:index, :new, :create]
  before_action :definirControlador, :quitarBandera

  def definirControlador
    @controlador = 'tipos_pagos'
    @controladorSingular = 'el tipo de pago'
  end

  def quitarBandera
    @creacion = false
  end

  def index
    @tipopagos= TiposPago.all.order :nombre
  end

  def show
    @tipopagos = TiposPago.find(params[:id])
  end

  def new
    @tipopagos = TiposPago.new
    @creacion = true
  end

  def edit
  end

  def create
    @tipopagos= TiposPago.new(tipopago_params)
    if TiposPago.find_by(nombre: params[:tipos_pago][:nombre]).blank?
      if @tipopagos.save
        flash[:success] = "Tipo de Pago creado exitosamente"
        redirect_to tipos_pagos_path
      else
        flash[:error]= "Error al crear  tipo de pago"
        render :new
      end
    else
      @creacion = true
      flash[:info] = 'El tipo de pago: ' + @tipopagos.nombre + ' ya está registrado en el sistema';
      render :new 
    end
  end

  def update
    if TiposPago.where('id != ? and nombre = ?', params[:id], params[:tipos_pago][:nombre]).present?
      flash[:info]= "Tipo de pago: " + params[:tipos_pago][:nombre] +" ya está registrado en el sistema"
      render :edit
    else
      if @tipopagos.update(tipopago_params)
        flash[:success]= "Tipo de pago actualizado exitosamente"
        redirect_to tipos_pagos_path
      else
        flash[:error]= "Error al actualizar tipo de pago"
        render :edit
      end
    end
  end

  def destroy
    if @tipopagos.destroy
      flash[:success]= "Tipo de pago eliminado exitosamente"
      redirect_to tipos_pagos_path
    else
      flash[:error]= "Error al eliminar tipo de pago"
    end
  end

  private
  # strong params, evita personas maliciosas puedan inyectar
  def tipopago_params
    params.require(:tipos_pago).permit(:nombre) ## tipos_pago hace referencia con el archivo tipos_pago.rb
  end

  #metodos que son llmados en ciertos momnetos del ciclo de vida
  # es guardadom, actualizado
  # usar callback para compartir configurarcones o renstricciones

  def set_tipopagos
    @tipopagos = TiposPago.find(params[:id])
  end
end