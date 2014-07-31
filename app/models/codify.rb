class Codify < ActiveRecord::Base
	self.establish_connection :local
	#attr_accessible :codditt, :code_letto, :code_alternative, :codlsar, :code_default, :verified, :pezzi_rilevati, :lotto_rilevato

	def validate_list
    List.where(codditt:self.codditt,tb_codlsar:self.codlsar).count > 0
  end

  def validate_code
    if check_code(self)
      return true
    else
      return false
    end
  end
  def check_code(obj)
    return true if obj.verified
    artico = Artico.select("ar_codart,ar_codalt,ar_descr,ar_codvar1,codditt").where(codditt:obj.codditt, ar_codart:obj.code_letto)
    unless artico.blank?
      if obj.code_letto == artico.ar_codart 
        obj.verified = true
      elsif obj.code_letto == artico.ar_codalt
        obj.verified = true
      else
        obj.verified  = false
        return false  
      end
      return true
    else
      obj.verified  = false
      return false
    end
  
  end

  def save_all
    if save_list(self)
      save_article(self)
    else
      false
    end

  end

  def list_articles_for_validation
    #cerco in oyster
    artico = Artico.select("ar_codart,ar_codalt,ar_descr,ar_codvar1, codditt").where(codditt:'OYSTER', ar_codart:self.code_letto)
    unless artico.blank?
      cod_alt = artico.first.ar_codalt.split(/[X|x]/)[0] unless artico.first.ar_codalt.blank?

      articles =  Artico.select("ar_codart,ar_codalt,ar_descr,ar_codvar1, codditt").where("codditt=? and ar_codart like ?",'NYCE',cod_alt+'%') unless cod_alt.blank?

      return articles || nil
    else
      return nil
    end
  end


  
  def save_list(obj)
    Rails.logger.debug "SAVE_LIST=" + obj.inspect.to_s

    last_article = Detail.lista(obj.codlsar).where(codditt:obj.codditt).last
    new_lsa_riga = 1
    unless last_article.blank?
      new_lsa_riga = last_article.lsa_riga.to_i + 1
    end
    
    a = Detail.new(codditt:obj.codditt,lsa_codart:obj.code_letto, lsa_codlsar:obj.codlsar,lsa_riga:new_lsa_riga,lsa_esist:obj.pezzi_rilevati,lsa_lotto:obj.lotto_rilevato.to_i)
    a.save!

  end
  def save_article(obj)
     obj.save
  end


  # def method_missing(meth, *args, &block)
  #   if meth.to_s =~ /^check_code_(.+)$/
  #   	run_check_code($1, *args, &block)
  #   else
  #     super 
  #   end
  # end

  

end
