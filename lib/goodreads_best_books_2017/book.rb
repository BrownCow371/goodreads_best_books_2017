class GoodreadsBestBooks2017::Book

  attr_accessor :title, :author, :desc, :stars, :book_format, :pages, :published, :url, :title_author

  @@all = []
  #@@all = ["Book 1", "Book 2", "Book 3", "Book 4", "Book 5", "Book 6", "Book 7"]

  def self.all
    @@all
  end

  def self.reset
    self.all.clear
  end

  def initialize(book_hash)
    book_hash.each {|key, value| self.send(("#{key}="), value)}
    self.class.all<<self
  end

  def self.new_from_array(book_array)
    book_array.each {|book_hash| self.new(book_hash)}
  end

  # def add_attributes(attribute_hash)
  #   attribute_hash.each {|key, value| self.send(("#{key}="), value)}
  # end

  def title
    @title ||= profile_scrape.css("h1#bookTitle").text.strip.gsub("\n","").gsub("                (", " (")
  end

  def author
    @author ||= profile_scrape.css("a.authorName").text
  end

  def desc
    #this one may need work - test on Category 8 - humor. One of the books is missing a summary paragraph.
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
