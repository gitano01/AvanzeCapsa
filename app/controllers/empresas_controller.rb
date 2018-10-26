class EmpresasController < ApplicationController
  before_action :set_empresa, except: [:index, :new, :create]
  before_action :quitarBandera, :definirControlador

  def definirControlador
    @controlador = 'empresas'
    @controladorSingular = 'la empresa'
  end

  def quitarBandera
    @creacion = false
  end

  def index
    @empresa = Empresa.first
  end
  def new
    @empresa = Empresa.new
    @creacion = true
  end
  def show
    @empresa = Empresa.find(params[:id])
  end

  def edit
  end

  def create
    @empresa = Empresa.new(empresa_params)
    if @empresa.save
      flash[:success] = "Empresa registrada exitosamente"
      redirect_to empresas_path
    else
      flash[:danger] = @empresa.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @empresa.update(empresa_params)
      flash[:success] ="Empresa actualizada exitosamente"
      redirect_to empresas_path
    else
      render :edit
    end

  end

  def destroy
  end

  private
  def empresa_params
    params.require(:empresa).permit(:nombre,:rfc,:iva,:imagen)
  end

  def set_empresa
    @empresa = Empresa.find(params[:id])
  end

end
