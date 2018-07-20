class GoodreadsBestBooks2017::Book

  attr_accessor :title, :author, :summary, :stars, :format, :pages, :published

  @@all = []

  def self.all
    @@all
  end

  def self.reset
    self.all.clear
  end

  def initialize
    self.class.all<<self
  end

  def self.new_from_page(stuff)
  end

end
