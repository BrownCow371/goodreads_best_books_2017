class GoodreadsBestBooks2017::Category

  attr_accessor :name, :url

  @@all =[]
  #@@all = ["Fiction", "Romance", "Mystery", "Teen", "Science Fiction"]

  def initialize(name, url)
    self.name = name
    self.url = url
    self.class.all<<self
  end

  def self.all
    @@all
  end

end
