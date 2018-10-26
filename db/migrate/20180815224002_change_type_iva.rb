class ChangeTypeIva < ActiveRecord::Migration

  def up
    change_table :empresas do |t|
      t.change :iva, :integer
    end
  end

  def down
    change_table :empresas do |t|
      t.change :iva, :double
    end
  end
end
