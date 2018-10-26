class TerminalesController < ApplicationController
  before_action :set_terminal, except: [:index, :new, :create, :caja_registradora]
  before_action :quitarBandera, :definirControlador

  def definirControlador
    @controlador = 'terminales'
  end

  def quitarBandera
    @creacion = false
  end

  def index
    @terminales = Terminal.all
  end

  def new
    @terminal = Terminal.new
    @caja_registradora = CajasRegistradora.new
    nueva_terminal
  end

  def show
    @terminal = Terminal.find(params[:id])
    @sucursales = Sucursal.all
    @inventarios = Inventario.all
  end

  def edit
    @terminal = Terminal.find(params[:id])
    @caja_registradora = CajasRegistradora.new
    @sucursales = Sucursal.all
    @inventarios = Inventario.all
  end

  def nueva_terminal
    @sucursales = Sucursal.all
    @inventarios = Inventario.all
    @creacion  = true  
  end

  def create
    @terminal = Terminal.new(terminal_params)
    @terminal.sucursal_id = params[:sucursal_id]
    @terminal.inventario_id = params[:inventario_id]
    if params[:opciones]=='no'
      if Terminal.find_by(nombre: params[:terminal][:nombre]).present?
        @caja_registradora = CajasRegistradora.new
        nueva_terminal
        flash[:info] = @terminal.nombre + ' ya está registrada en el sistema'
        render :new
      else
        if @terminal.save
          flash[:success] = "Terminal creada exitosamente"
          redirect_to @terminal
        end
      end
    elsif params[:terminal][:cajas_registradora_id].blank?
      if Terminal.find_by(nombre: params[:terminal][:nombre]).present?
        nueva_terminal
        flash[:info] = @terminal.nombre + ' ya está registrada en el sistema'
        render :new
      else
        @caja_registradora = CajasRegistradora.new(caja_registradora_params)
        if @caja_registradora.save
          @terminal.caja_registradora_habilitada = true
        else
          @terminal.caja_registradora_habilitada = false
        end
        @terminal.cajas_registradora_id = @caja_registradora.id
        if @terminal.save
          flash[:success] = "Terminal creada exitosamente"
          redirect_to @terminal
        end
      end
    else
      if Terminal.find_by(nombre: params[:terminal][:nombre]).present?
        @caja_registradora = CajasRegistradora.new
        nueva_terminal
        flash[:info] = @terminal.nombre + ' ya está registrada en el sistema'
        render :new
      else
        @terminal.cajas_registradora_id = params[:terminal][:cajas_registradora_id]
        @terminal.caja_registradora_habilitada = true
        if @terminal.save
          flash[:success] = "Terminal creada exitosamente"
          redirect_to @terminal
        end
      end
    end
  end
  
  def actualiza
    @terminal = Terminal.find(params[:id])
    if params[:opciones]=='no'
      @terminal.cajas_registradora_id = nil
      if @terminal.update(terminal_params)
        flash[:success] = "Terminal actualizada exitosamente"
        redirect_to @terminal
      end
    elsif params[:terminal][:cajas_registradora_id].blank?
      @caja_registradora = CajasRegistradora.new(caja_registradora_params)
      if @caja_registradora.save
        @terminal.caja_registradora_habilitada = true
      else
        @terminal.caja_registradora_habilitada = false
      end
      @terminal.cajas_registradora_id = @caja_registradora.id
      if @terminal.update(terminal_params)
        flash[:success] = "Terminal actualizada exitosamente"
        render :show
      else
        render :edit
      end
    else
      @terminal.cajas_registradora_id = params[:terminal][:cajas_registradora_id]
      if @terminal.update(terminal_params)
        flash[:success] = "Terminal actualizada exitosamente"
        render :show
      else
        render :edit
      end
    end 
  end

  def destroy
    @terminal = Terminal.find(params[:id])
    @terminal.destroy
    flash[:success] = "Terminal eliminada exitosamente."
    redirect_to terminales_path
  end

  def terminal_params
    params.require(:terminal).permit(:sucursal_id, :inventario_id, :nombre, :caja_registradora_habilitada)
  end

  def caja_registradora_params
    params.require(:caja_registradora).permit(:nombre, :monto_inicial)
  end

  private
  def set_terminal
    @terminal = Terminal.find(params[:id])
  end

end




