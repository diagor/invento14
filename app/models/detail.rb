class Detail < ActiveRecord::Base
  self.table_name = 'dbo.listsar'
  self.primary_key = 'lsa_riga'

  attr_accessor :tara

  scope :lista, lambda { |cod| where("lsa_codlsar=?",cod) }
  scope :find_article, lambda { |args| where(lsa_codart:args[:lsa_codart],codditt:args[:codditt],lsa_codlsar:args[:lsa_codlsar]).first }
  # attr_accessible :lsa_codart, :lsa_lotto, :lsa_esist, :codditt, :lsa_codlsar, :lsa_trattato, :lsa_riga, :ts, :tara


  belongs_to :list

  validates :lsa_codart, presence: true
  validates :lsa_esist, :lsa_lotto, numericality: true
  #validates_length_of :lsa_esist, :minimum => , :too_short => "please enter at least 5 characters"
  validates :lsa_lotto, :numericality => { :greater_than => 0, :message => "Inserire lotto valido" }, :if => "codditt==#{Configatron.general.codditt.one}"

  def tara=(val)
   @tara = val
  end

  def tara
    @tara
  end

  def self.completed
    where(lsa_trattato:'S').count
  end

  def self.total
    count
  end

  def self.are_completed?
    ( (total - completed) == 0 )
  end

  def self.exist_lot?(args)
    if select("lsa_lotto").where(lsa_codart:args[:lsa_codart],codditt:args[:codditt],lsa_codlsar:args[:lsa_codlsar]).first.lsa_lotto > 0
      true
    else
      false
    end
  end

  def self.have_this?(codart,codditt,codlsar)
    where(lsa_codart:codart,codditt:codditt,lsa_codlsar:codlsar).exists?
  end

  def self.last_row(args)
    where(codditt:args[:codditt],lsa_codlsar:args[:lsa_codlsar]).last
  end

  #def self.find_article(args)
  #  where(lsa_codart:args[:lsa_codart],codditt:args[:codditt],lsa_codlsar:args[:lsa_codlsar]).first
  #end

  def self.save_article(object)
    connection.update("UPDATE listsar SET lsa_lotto=#{object.lsa_lotto}, lsa_esist=#{object.lsa_esist}, lsa_trattato='#{object.lsa_trattato}'
                      WHERE lsa_codlsar=#{object.lsa_codlsar} AND codditt='#{object.codditt}' AND lsa_riga=#{object.lsa_riga}
                      ")
  end

  def self.insert_article(object)
    connection.update("INSERT INTO listsar VALUES (DEFAULT,'#{object.lsa_codart}',null,#{object.lsa_codlsar},#{object.lsa_riga.to_i}.0,'N',0,'#{object.codditt}',0,#{object.lsa_lotto},'','',#{object.lsa_esist},'#{object.lsa_trattato}',0,'',0,'')")
  end
  def is_real_article?(tara)
     unless self.lsa_codart.blank?
        if self.lsa_codart.to_i > 0
          a = Barcode.find_by(self)
          if tara.to_f == 0.0
            return false
          end

          if  a && Detail.have_this?(a.ar_codart,self.codditt,self.lsa_codlsar)
            true
          else
            false
          end
        else
          split_article(self) if self.lsa_lotto.to_i == 0
          Artico.exist_codice_articolo?(self) && check_article(self)
        end

     else
       false
     end
  end

  def split_article(args)
    a=args[:lsa_codart].split('$')
    self.lsa_codart = a[0]
    self.lsa_lotto = a[1]
  end

  def has_valid_lot?
    if self.codditt.upcase == Configatron.general.codditt.one
      self.lsa_lotto.to_s.size >= 5 && Analotti.exist_lotto(self)
    end
  end

  def is_a_new_lot?
    Detail.exist_lot?(self)
  end

  def get_new_row

    (Detail.last_row(self).lsa_riga  + 1.0).to_i


  end

  def selecting
    Detail.where(lsa_codart:self.lsa_codart,codditt:self.codditt,lsa_codlsar:self.lsa_codlsar).first
  end

  private

    def check_article(args)
      Detail.where(lsa_codart:args[:lsa_codart],codditt:args[:codditt],lsa_codlsar:args[:lsa_codlsar]).count > 0

    end






end