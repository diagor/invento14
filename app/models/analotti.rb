class Analotti < ActiveRecord::Base
  self.table_name = 'dbo.analotti'
  self.primary_key = 'ts'

  # attr_accessible :alo_codart, :alo_lotto, :codditt, :alo_lottox, :alo_codlotx,
                  # :alo_dtprep, :alo_dtscad, :alo_dtcarbus

  def self.exist_lotto(args)
    Rails.logger.debug "ANALOTTI - args=" + args.inspect
    where(alo_codart: args[:lsa_codart], codditt: args[:codditt], alo_lotto:args[:lsa_lotto]).count > 0
  end
  
end