class GoodreadsBestBooks2017::Book

  attr_accessor :title, :author, :summary, :stars, :format, :pages, :published

  #@@all = []
  @@all = ["Book 1", "Book 2", "Book 3", "Book 4", "Book 5", "Book 6", "Book 7"]

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
