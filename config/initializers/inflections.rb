# Be sure to restart your server when you modify this file.

#Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
 ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
   inflect.plural /(r|n|d|l)$/i, '\1es'
   inflect.singular /(r|n|d|l)es$/i, '\1'
   inflect.irregular 'user','users'
   inflect.irregular 'User','Users'
   inflect.irregular 'categoria', 'categorias'
   inflect.irregular 'unidad','unidades'
   inflect.irregular 'empresa', 'empresas'
   inflect.irregular 'terminal', 'terminales'
   inflect.irregular 'Terminal', 'Terminales'
   inflect.irregular 'sucursal', 'sucursales'
   inflect.irregular 'Sucursal', 'Sucursales'
   inflect.irregular 'promocion', 'promociones'
   inflect.irregular 'Promocion', 'Promociones'
   inflect.irregular 'proveedor', 'proveedores'
   inflect.irregular 'Proveedor', 'Proveedores'
   inflect.irregular 'cliente', 'clientes'
   inflect.irregular 'Cliente', 'Clientes'
   inflect.irregular 'categoria', 'categorias'
   inflect.irregular 'Categoria', 'Categorias'
   inflect.irregular 'rol', 'roles'
   inflect.irregular 'Rol', 'Roles'
   inflect.irregular 'usuario', 'usuarios'
   inflect.irregular 'Usuario', 'Usuarios'
   inflect.irregular 'modulo', 'modulos'
   inflect.irregular 'Modulo', 'Modulos'
   inflect.irregular 'sucursal', 'sucursales'
   inflect.irregular 'Sucursal', 'Sucursales'
   inflect.irregular 'CajaRegistradora', 'CajasRegistradoras'
   inflect.irregular 'CajasRegistradora', 'CajasRegistradoras'
#   inflect.uncountable %w( fish sheep )
 end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end
