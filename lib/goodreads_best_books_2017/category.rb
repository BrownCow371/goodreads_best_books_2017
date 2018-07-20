class GoodreadsBestBooks2017::Category

  attr_accessor :name, :url

  @@all =[]

  def initialize
    self.class.all<<self
  end

  def self.all
    @@all
  end

end
