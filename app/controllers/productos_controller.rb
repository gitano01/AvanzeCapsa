class ProductosController < ApplicationController
  before_action :definirControlador,:quitarBandera

  def formulario_kit
    @productos = Categoria.find(params[:cat_id].to_i).productos.where("kit = false")
    respond_to do |format|
      format.js
    end
  end
  def agregar_producto_kit
    @producto_kit = Producto.find(params[:pro_id].to_i)
    respond_to do |format|
      format.js
    end
  end
  def index
    @productos = Producto.all
    @categorias = Categoria.all
    @unidades = Unidad.all.sort
  end
  def new
    @productos = Categoria.first.productos.where("kit = false")
    @producto = Producto.new
    @categorias = Categoria.all
    @unidades = Unidad.all.sort
    @categorias_enlazadas = Array.new
    @creacion = true
  end
  def create
    #flash[:success] = params[:productos_kit]
    @producto = Producto.new(paramsDeProducto)
    if @producto.save
      agregarCategorias unless params[:categoria].nil?  #solo entra en la función si no es nil el parametro
      flash[:success] = "Producto creado exitosamente"
      agregarProductoskit if @producto.kit
      redirect_to @producto
    else
      flash[:error] ="Error al crear el producto"
    end

  end
  def show
    @producto = Producto.find(params[:id])
    @unidad=Unidad.find(@producto.unidad_id)
    @productos_del_kit = Kit.where("producto_padre_id = ?",@producto.id.to_i) if @producto.kit
  end
  def edit
    @productos = Categoria.first.productos
    @producto = Producto.find(params[:id])
    @categorias = Categoria.all
    @unidades = Unidad.all.sort
    @categorias_enlazadas = @producto.categorias #variable para indicar que categorías están enlazadas
    @productos_del_kit = Kit.where("producto_padre_id = ?",@producto.id.to_i) if @producto.kit
  end
  def update
    @producto = Producto.find(params[:id])
    if @producto.update(paramsDeProducto)
      @producto.categorias.clear # se borra de la base de datos antes de volver a agregar
      agregarCategorias unless params[:categoria].nil? #solo entra en la función si no es nil el parametro
      Kit.where("producto_padre_id = ?",@producto.id.to_i).delete_all
      agregarProductoskit if @producto.kit
      flash[:success] = "Producto actualizado exitosamente"
      redirect_to @producto
    else
      flash[:error] = "Error al actualizar el producto"
      render 'edit'
    end
  end
  def destroy
    @producto = Producto.find(params[:id].to_i)
    if @producto.kit
      Kit.where("producto_padre_id = ?",@producto.id).delete_all
    end
    if @producto.destroy
      flash[:success] = "Producto eliminado exitosamente"
      redirect_to @producto
    else
      flash[:error] = "Error al eliminar el producto"
    end

  end
  def checkKit
    respond_to do |format|
      format.js
    end
  end
  private
    def paramsDeProducto
      params.require(:producto).permit(:nombre,:definicion,:codigo,:lugar,:kit,:disponible_en_inventario,:unidad_id,:precio,:precio_costo,:iva,:imagen)
    end
    def agregarCategorias #funcion de agregar categorias
      params[:categoria].each do |c|
        categoria_enlazar = Categoria.find(c)
        @producto.categorias << categoria_enlazar
      end
    end
    def definirControlador
      @controlador = 'productos'
      @controladorSingular = 'el producto'
    end
    def quitarBandera
      @creacion = false
    end
    def agregarProductoskit
        kit_productos = params[:productos_kit].split(",")
        kit_cantidades = params[:cantidades_kit].split(",")
        i=0
        kit_productos.each do |p|
          kit = Kit.new
          kit.producto_padre_id=@producto.id
          kit.producto_id = p.to_i
          kit.cantidad = kit_cantidades[i].to_i
          kit.save
          i=i+1
        end
    end
end