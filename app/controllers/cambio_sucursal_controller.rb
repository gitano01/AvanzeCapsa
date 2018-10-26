class CambioSucursalController < ApplicationController

 #before_action :set_impuesto, except: [:index, :new, :create]


  def index
    @terminales = Terminal.all
    @terminales_ = []
    for t in @terminales
      @terminales_ << {:id => t.id, :sucursal => t.sucursal.nombre}
    end
    @terminales_ = @terminales_.sort_by { |i| i[:sucursal] }
    @terminales_ids = @terminales_.map{ |i| i[:id] }
    @terminales = []
    for t in @terminales_ids
      @terminales << (Terminal.find t)
    end
  end

  def cambiar
      cookies.permanent["TerminalActual"] = params[:id_ter]
      redirect_to cambio_sucursal_path(params[:id_ter])
  end
end
