# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20181024154636) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cajas_registradoras", force: :cascade do |t|
    t.string   "nombre"
    t.decimal  "monto_inicial"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "categorias", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categorias_productos", id: false, force: :cascade do |t|
    t.integer "categoria_id"
    t.integer "producto_id"
  end

  create_table "clientes", force: :cascade do |t|
    t.string   "nombre"
    t.string   "rfc"
    t.string   "email"
    t.string   "telefono"
    t.string   "direccion"
    t.string   "ciudad"
    t.string   "estado"
    t.string   "codigo_Postal"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "descuentos", force: :cascade do |t|
    t.integer  "usuario_id"
    t.integer  "terminal_id"
    t.string   "nombre"
    t.integer  "monto"
    t.date     "fecha_inicial"
    t.date     "fecha_final"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "descuentos", ["terminal_id"], name: "index_descuentos_on_terminal_id", using: :btree
  add_index "descuentos", ["usuario_id"], name: "index_descuentos_on_usuario_id", using: :btree

  create_table "descuentos_productos", force: :cascade do |t|
    t.integer  "descuento_id"
    t.integer  "producto_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "descuentos_productos", ["descuento_id"], name: "index_descuentos_productos_on_descuento_id", using: :btree
  add_index "descuentos_productos", ["producto_id"], name: "index_descuentos_productos_on_producto_id", using: :btree

  create_table "empleados", force: :cascade do |t|
    t.string   "nombre_completo"
    t.string   "apellido_paterno"
    t.string   "apellido_materno"
    t.string   "rfc"
    t.date     "fecha_nacimiento"
    t.date     "fecha_registro"
    t.string   "direccion"
    t.string   "ciudad"
    t.string   "estado"
    t.string   "codigo_postal"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "empresas", force: :cascade do |t|
    t.string   "nombre"
    t.string   "rfc"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "iva"
    t.string   "imagen_file_name"
    t.string   "imagen_content_type"
    t.integer  "imagen_file_size",    limit: 8
    t.datetime "imagen_updated_at"
  end

  create_table "inventarios", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kits", force: :cascade do |t|
    t.integer  "producto_padre_id"
    t.integer  "producto_id"
    t.integer  "cantidad"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "modulos", force: :cascade do |t|
    t.string   "nombre_controlador"
    t.string   "nombre"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "modulos_usuarios", force: :cascade do |t|
    t.integer  "usuario_id"
    t.integer  "modulo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "modulos_usuarios", ["modulo_id"], name: "index_modulos_usuarios_on_modulo_id", using: :btree
  add_index "modulos_usuarios", ["usuario_id"], name: "index_modulos_usuarios_on_usuario_id", using: :btree

  create_table "productos", force: :cascade do |t|
    t.string   "nombre"
    t.string   "definicion"
    t.string   "codigo"
    t.string   "lugar"
    t.float    "precio"
    t.float    "precio_costo"
    t.boolean  "iva"
    t.boolean  "disponible_en_inventario"
    t.boolean  "kit"
    t.integer  "unidad_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "imagen_file_name"
    t.string   "imagen_content_type"
    t.integer  "imagen_file_size",         limit: 8
    t.datetime "imagen_updated_at"
  end

  add_index "productos", ["unidad_id"], name: "index_productos_on_unidad_id", using: :btree

  create_table "proveedores", force: :cascade do |t|
    t.string   "nombre"
    t.string   "contacto"
    t.string   "servicio"
    t.string   "rfc"
    t.string   "email"
    t.string   "telefono"
    t.string   "direccion"
    t.string   "ciudad"
    t.string   "estado"
    t.string   "codigo_Postal"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sucursales", force: :cascade do |t|
    t.string   "nombre"
    t.string   "telefonos"
    t.string   "iniciales"
    t.string   "direccion"
    t.string   "ciudad"
    t.string   "estado"
    t.string   "codigo_postal"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "terminales", force: :cascade do |t|
    t.integer  "sucursal_id"
    t.integer  "cajas_registradora_id"
    t.integer  "inventario_id"
    t.string   "nombre"
    t.boolean  "caja_registradora_habilitada"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "terminales", ["cajas_registradora_id"], name: "index_terminales_on_cajas_registradora_id", using: :btree
  add_index "terminales", ["inventario_id"], name: "index_terminales_on_inventario_id", using: :btree
  add_index "terminales", ["sucursal_id"], name: "index_terminales_on_sucursal_id", using: :btree

  create_table "tipos_pagos", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "unidades", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "usuarios", force: :cascade do |t|
    t.integer  "empleado_id"
    t.integer  "rol_id"
    t.string   "usuario"
    t.string   "email"
    t.string   "tipo"
    t.string   "contrasena_cifrado"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "usuarios", ["empleado_id"], name: "index_usuarios_on_empleado_id", using: :btree
  add_index "usuarios", ["rol_id"], name: "index_usuarios_on_rol_id", using: :btree

  add_foreign_key "descuentos", "terminales"
  add_foreign_key "descuentos", "usuarios"
  add_foreign_key "descuentos_productos", "descuentos"
  add_foreign_key "descuentos_productos", "productos"
  add_foreign_key "modulos_usuarios", "modulos"
  add_foreign_key "modulos_usuarios", "usuarios"
  add_foreign_key "terminales", "cajas_registradoras"
  add_foreign_key "terminales", "inventarios"
  add_foreign_key "terminales", "sucursales"
  add_foreign_key "usuarios", "empleados"
  add_foreign_key "usuarios", "roles"
end
