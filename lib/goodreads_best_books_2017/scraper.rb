class GoodreadsBestBooks2017::Scraper

  def self.get_page_categories
    Nokogiri::HTML(open("https://www.goodreads.com/choiceawards/best-books-2017"))
  end

  def self.scrape_categories_index
    self.get_page_categories.css("div.categoryContainer div.category.clearFix")
  end

  def self.make_categories
    self.scrape_categories_index.each do |c|
      name = c.css("h4").text
      url = c.css("a").attribute("href").text
      GoodreadsBestBooks2017::Category.new(name, url)
    end
  end

  def self.get_page_books(category_url)
    #want full URL to be called to be something like https://www.goodreads.com/choiceawards/best-fiction-books-2017
    #and cateogry URLs are stored as /choiceawards/best-fiction-books-2017
    Nokogiri::HTML(open("https://www.goodreads.com#{category_url}")).css("a.pollAnswer__bookLink")
  end

  def self.scrape_books_index(category_url)
    self.get_page_books(category_url).collect do |book|
      { url: book.attribute("href").text,
        title_author: book.css("img").attribute("alt").text,
        category_url: category_url
      }
    end
  end

  def self.make_books(category_url)
    book_array = scrape_books_index(category_url)
    GoodreadsBestBooks2017::Book.new_from_array(book_array)
  end
end
