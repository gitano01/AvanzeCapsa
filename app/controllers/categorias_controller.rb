class CategoriasController < ApplicationController
    before_action :definirControlador,:quitarBandera
  def definirControlador
    @controlador = 'categorias'
    @controladorSingular = 'la categoría'
  end
  def quitarBandera
    @creacion = false
  end
  def new
    @categoria = Categoria.new
    @creacion = true
  end

  def create
    @categoria = Categoria.new(paramsDeCategoria)
    if Categoria.find_by(nombre: params[:categoria][:nombre].strip).blank?
      if @categoria.save
        flash[:success] = "Categoría creada exitosamente"
        redirect_to categorias_path
      else
        flash[:error] = "Error al crear categoría"
        render :new
      end
    else
      flash[:info] = 'La categoría: ' + params[:categoria][:nombre] + ' ya está registrada en el sistema'
      @creacion = true
      render :new
    end
  end

  def show
    @categoria = Categoria.find(params[:id])
  end

  def index
    @categorias = Categoria.all
  end

  def edit
    @categoria = Categoria.find(params[:id])
  end
  def update
    @categoria = Categoria.find(params[:id])
    if Categoria.where('id != ? and nombre = ?', params[:id], params[:categoria][:nombre].strip).present?
      flash[:info] = 'La categoría: ' + params[:categoria][:nombre] + ' ya está registrada en el sistema'
      render :edit
    else
      if @categoria.update(paramsDeCategoria)
        flash[:success] = "Categoría actualizada exitosamente"
        redirect_to categorias_path
      else
        flash[:error] = "Error al actualizar categoría"
        render 'edit'
      end
    end
  end
  def destroy
    @categoria = Categoria.find(params[:id])
    begin
      if @categoria.productos.size > 0
        raise @categoria.productos.size.to_s
      end
      @categoria.destroy
      flash[:success] = "Categoría eliminada exitosamente"
      redirect_to categorias_path
    rescue Exception => e
      flash[:danger] = "La categoría no se puede eliminar porque existen "+e.message+" productos en la categoría " + @categoria.nombre
      redirect_to categorias_path
    end
  end
  private
  def paramsDeCategoria
    params.require(:categoria).permit(:nombre)
  end
end
