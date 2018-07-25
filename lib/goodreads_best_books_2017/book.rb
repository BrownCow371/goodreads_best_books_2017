class GoodreadsBestBooks2017::Book

  attr_accessor :title, :author, :desc, :stars, :book_format, :pages, :published, :url, :title_author, :category_url

  @@all = []

  def self.all
    @@all
  end

  # def self.reset
  #   self.all.clear
  # end

  def initialize(book_hash)
    book_hash.each {|key, value| self.send(("#{key}="), value)}
    self.class.all<<self
  end

  def self.new_from_array(book_array)
    book_array.each {|book_hash| self.new(book_hash)}
  end

  # def self.find_by_id(id)
  #   @@all[id.to_i-1]
  # end

  def self.find_by_category(category_url)
    self.all.collect {|b|  b if b.category_url == category_url}
  end

  end

  def title
    @title ||= profile_scrape.css("h1#bookTitle").text.strip.gsub("\n","").gsub("                (", " (")
  end

  def author
    @author ||= profile_scrape.css("a.authorName").text
  end

  def desc
    if profile_scrape.css("div#description span")[0] != nil
      @desc ||= profile_scrape.css("div#description span")[0].text.gsub("â\u0080\u0094", "")
    else
      @desc ||= ""
    end
  end

  def stars
    @stars ||= profile_scrape.css("span.value.rating span").text
  end

  def book_format
    @book_format ||= profile_scrape.css("div#details div span[itemprop='bookFormat']").text
  end

  def pages
    @pages ||= profile_scrape.css("div#details div span[itemprop='numberOfPages']").text
  end

  def published
    @published ||= profile_scrape.css("div#details div.row")[1].text.strip.gsub("\n","")
  end

  def profile_scrape
    @doc ||= Nokogiri::HTML(open("https://www.goodreads.com#{self.url}")).css("div#metacol")
  end
end
