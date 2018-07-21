class GoodreadsBestBooks2017::Book

  attr_accessor :title, :author, :desc, :stars, :book_format, :pages, :published, :url

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
      self.new.tap{|b| b.url = book_url}
    end
  end

  # def add_attributes(attribute_hash)
  #   attribute_hash.each {|key, value| self.send(("#{key}="), value)}
  # end

  #       summary =  profile.css("div#description span")[0].text.gsub("â\u0080\u0094", "") if profile.css("div#description span")[0] != nil
  #       book_profile = {
  #         title: profile.css("h1#bookTitle").text.strip.gsub("\n","").gsub("                (", " ("),
  #         author: profile.css("a.authorName").text,
  #         stars: profile.css("span.value.rating span").text,
  #         book_format: profile.css("div#details div span[itemprop='bookFormat']").text,
  #         pages: profile.css("div#details div span[itemprop='numberOfPages']").text,
  #         published: profile.css("div#details div.row")[1].text.strip.gsub("\n",""),
  #         desc: summary

  def title
  end

  def author
  end

  def desc
  end

  def stars
  end

  def book_format
  end

  def pages
  end

  def published
  end

  def profile_scrape
    @doc ||= Nokogiri::HTML(open("https://www.goodreads.com#{self.url}")).css("div#metacol")
  end

end
