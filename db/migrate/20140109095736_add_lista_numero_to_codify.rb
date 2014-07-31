class AddListaNumeroToCodify < ActiveRecord::Migration
  def up
    add_column :codifies, :codlsar, :integer
  end

  def down
    remove_column :codifies, :codlsar
  end
end
