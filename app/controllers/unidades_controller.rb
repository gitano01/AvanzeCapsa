class UnidadesController < ApplicationController
  before_action :definirControlador,:quitarBandera
  def definirControlador
    @controlador = 'unidades'
    @controladorSingular = 'la unidad'
  end
  def quitarBandera
    @creacion = false
  end
  def new
    @unidad = Unidad.new
    @creacion = true
  end


  def create
    @unidad = Unidad.new(paramsDeunidad)
    if Unidad.find_by(nombre: params[:unidad][:nombre]).blank?
      if @unidad.save
        flash[:success] = "Unidad creada exitosamente"
        redirect_to unidades_path
      else
        flash[:error] ="Error al crear la unidad"
      end
    else
      flash[:info] = 'La unidad: ' + params[:unidad][:nombre] + ' ya está registrada en el sistema'
      @creacion = true
      render :new
    end
  end
  def show
    @unidad = Unidad.find(params[:id])
  end

  def index
    @unidades = Unidad.all
  end

  def edit
    @unidad = Unidad.find(params[:id])
  end
  
  def update
    @unidad = Unidad.find(params[:id])
    if Unidad.where('id != ? and nombre = ?', params[:id], params[:unidad][:nombre]).present?
      flash[:info] = 'La unidad: ' + params[:unidad][:nombre] + ' ya está registrada en el sistema'
      render :edit
    else
      if @unidad.update(paramsDeunidad)
        flash[:success] = "Unidad actualizada exitosamente"
        redirect_to unidades_path
      else
        flash[:error] = "Error al actualizar la unidad"
        render 'edit'
      end
    end
  end
  def destroy
    @unidad = Unidad.find(params[:id])
    begin
      @unidad.destroy
      flash[:success] = "Unidad eliminada exitosamente"
      redirect_to unidades_path
    rescue
      flash[:danger] = "La unidad no se puede eliminar porque uno o más productos la utilizan"
      redirect_to unidades_path
    end
  end
  private
  def paramsDeunidad
    params.require(:unidad).permit(:nombre)
  end

end