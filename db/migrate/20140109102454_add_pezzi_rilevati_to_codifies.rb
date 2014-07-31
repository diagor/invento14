class AddPezziRilevatiToCodifies < ActiveRecord::Migration
  def up
    add_column :codifies, :pezzi_rilevati, :integer
  end
  def down
    remove_column :codifies, :pezzi_rilevati
  end
end
