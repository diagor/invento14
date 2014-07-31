class Barcode < ActiveRecord::Base
  self.table_name = 'dbo.barcode'
  self.primary_key = 'art.ts'

  def self.find_by(args)
    if args
      where(:bc_code=>args[:lsa_codart],:codditt=>args[:codditt]).first
    else
      false
    end
  end
end