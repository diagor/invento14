class List < ActiveRecord::Base
  self.table_name = 'dbo.tablsar'
  self.primary_key = 'tb_codlsar'

  scope :open , where(tb_status:['P','M'])
  # attr_accessible :title, :body

  has_many :details, :foreign_key => "lsa_codlsar"

  def self.search(args)
    unless args[:operatore].blank?
        where(codditt:args[:codditt],tb_opnomest:args[:operatore])
    end

  end

  def self.get_my_list(args)
    id = args[:list_id] || args[:id]
    where(tb_codlsar:id,codditt:args[:codditt]).first
  end

end
