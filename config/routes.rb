Rails.application.routes.draw do




  devise_for :users
  post 'productos/formulario_kit', as: 'formulario_kit'
  post 'productos/agregar_producto_kit', as: 'agregar_producto_kit'
  get 'welcome/index'
  resources :categorias
  resources :productos
  resources :unidades
  resources :configuraciones
  resources :empresas
  resources :cambio_sucursal
  resources :proveedores
  resources :clientes
  resources :tipos_pagos
  resources :inventarios
  resources :sucursales
  resources :terminales
  resources :cajas_registradoras
  resources :descuentos
  resources :cambio_sucursal do
    post :cambiar, :on => :collection
  end
  resources :empleados
  get 'permisos/mod_usuarios'
  get 'permisos/show_modulos'
  get 'permisos/mod_usuarios_rest'
  post 'terminales/actualiza'
  post 'terminales/caja_registradora'
  post 'permisos/guardar_cambios'
  post 'empleados/actualiza'
  post 'descuentos/opciones'
  post 'descuentos/agregar_producto'
  post 'descuentos/agregar_productos'
  post 'descuentos/obtener_categoria'
  post 'descuentos/total_producto'

  root 'welcome#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".



  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
