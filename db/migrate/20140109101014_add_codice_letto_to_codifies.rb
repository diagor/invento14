class AddCodiceLettoToCodifies < ActiveRecord::Migration
  def up
    add_column :codifies, :code_letto, :string
  end

  def down
    remove_column :codifies, :code_letto
  end
end
