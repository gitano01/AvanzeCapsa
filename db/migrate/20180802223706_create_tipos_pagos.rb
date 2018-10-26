class CreateTiposPagos < ActiveRecord::Migration
  def change
    create_table :tipos_pagos do |t|
      t.string :nombre

      t.timestamps null: false
    end
  end
end
