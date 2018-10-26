module ApplicationHelper

  def resource_name
    :usuario
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:usuario]
  end

end
