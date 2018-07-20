class GoodreadsBestBooks2017::Book

  attr_accessor :title, :author, :summary, :stars, :book_format, :pages, :published, :url

  @@all = []
  #@@all = ["Book 1", "Book 2", "Book 3", "Book 4", "Book 5", "Book 6", "Book 7"]

  def self.all
    @@all
  end

  def self.reset
    self.all.clear
  end

  def initialize
    self.class.all<<self
  end

  def self.new_from_array(book_url_array)
    book_url_array.each do |book_url|
      self.new.tap{|b| self.url = book_url}
    end
  end

  def add_attributes(attribute_hash)
    attribute_hash.each {|key, value| self.send(("#{key}="), value)}
  end

end
