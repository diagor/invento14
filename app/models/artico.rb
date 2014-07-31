class Artico < ActiveRecord::Base
  self.table_name = 'dbo.artico'
  self.primary_key = 'ts'

  def self.exist_codice_articolo?(args)
    if args
      where(:ar_codart=>args[:lsa_codart],:codditt=>args[:codditt]).count > 0
    else
      false
    end
  end

end