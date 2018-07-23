class GoodreadsBestBooks2017::Category

  attr_accessor :name, :url

  @@all = []

  def initialize(name, url)
    self.name = name
    self.url = url
    self.class.all << self
  end

  def self.all
    @@all
  end

  def self.find_by_id(id)
    @@all[id.to_i-1]
  end
end
