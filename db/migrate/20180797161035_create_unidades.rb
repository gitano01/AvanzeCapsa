class CreateUnidades < ActiveRecord::Migration
  def change
    create_table :unidades do |t|
      t.string :nombre
      t.timestamps null: false
    end
  end
end