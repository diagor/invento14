class CreateCodifies < ActiveRecord::Migration
  def up
    create_table :codifies   do |t|
      t.string :codditt
      t.string :code_default
      t.string :code_alternative
      t.boolean :verified
    end

  end

  def down
    drop_table :codifies
  end
end
