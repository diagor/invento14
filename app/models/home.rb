class Home

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :codditt, :operatore

  def initialize()
    
  end

  def persisted?
    false
  end

  def self.login(args)
    return [] if args[:operatore].blank?
    List.search(args).open
  end

end