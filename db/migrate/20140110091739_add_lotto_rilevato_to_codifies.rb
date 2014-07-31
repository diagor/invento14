class AddLottoRilevatoToCodifies < ActiveRecord::Migration
  def up
    add_column :codifies, :lotto_rilevato, :integer
  end

  def down
    remove_column :codifies, :lotto_rilevato
  end

end
