class RegistrationsController < Devise::RegistrationsController

  def new
      super
  end

  def update
    super
  end

  def create

  end

  def devise_parameters_sanitizer
  end

end
