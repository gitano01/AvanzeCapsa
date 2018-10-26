class DescuentosController < ApplicationController

  before_action :set_descuento, only: [:show, :edit, :update, :destroy]
  before_action :definirControlador, :quitarBandera

  # GET /descuentos
  def index
    @descuentos = Descuento.all
  end

  # GET /descuentos/1
  def show
  end

  # GET /descuentos/new
  def new
    @descuento = Descuento.new
    @categorias = Categoria.all
    @productos = []
    @creacion = true
  end

  def opciones
    #flash[:success] = params[:categoria][:id]
    @productos = Categoria.find(params[:categoria_id]).productos
  end

  def agregar_producto 
    @producto = Producto.find(params[:producto_id])
    respond_to do |format|
      format.json { render :json => @producto }      
    end
  end

  def agregar_productos
    @productos = Categoria.find(params[:categoria_id]).productos
    respond_to do |format|
      format.json { render :json => @productos }
    end
  end

  def total_producto
    @total_productos = Categoria.find(params[:categoria_id]).productos.count
    respond_to do |format|
      format.json { render :json => @total_productos }
    end
  end

  # GET /descuentos/1/edit
  def edit
    @categorias = Categoria.all
    @productos = []
    @editar = true
  end

  # POST /descuentos
  def create
    @descuento = Descuento.new(descuento_params)
    @productos = Producto.all
    if @descuento.save
      @descuento.productos.clear
      for m in @productos
        if params["#{m.id}"] == "1"
          @descuento.productos << m unless @descuento.productos.include? m
        end
      end
      flash[:success] = 'La promoción ha sido creada satisfactoriamente'
      redirect_to @descuento
    end
  end

  # PATCH/PUT /descuentos/1
  def update
    @productos = Producto.all
    if @descuento.update(descuento_params)
      @descuento.productos.clear
      for m in @productos
        if params["#{m.id}"] == "1"
          @descuento.productos << m unless @descuento.productos.include? m
        end
      end
      flash[:success] = 'La promoción ha sido actualizada satisfactoriamente'
      redirect_to @descuento
    else
      render :edit
    end
  end

  # DELETE /descuentos/1
  def destroy
    @descuento.destroy
    flash[:success] = 'La promoción ha sido eliminada satisfactoriamente'
    redirect_to descuentos_url
  end

  def definirControlador
      @controlador = 'descuentos'
      @controladorSingular = 'el descuento'
  end

  def quitarBandera
      @creacion = false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_descuento
      @descuento = Descuento.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def descuento_params
      params.require(:descuento).permit(:nombre, :monto, :fecha_inicial, :fecha_final)
    end
end