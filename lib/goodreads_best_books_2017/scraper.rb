class GoodreadsBestBooks2017::Scraper

  def get_page_categories

    d = Nokogiri::HTML(open("https://www.goodreads.com/choiceawards/best-books-2017"))

  end

  def scrape_categories_index
    cat = self.get_page_categories.css("div.categoryContainer div.category.clearFix h4")
    binding.pry
  end

  def make_categories
  end

  def get_page_books(category_url)
  end

  def scrape_books_index(category)
    self.get_page_books(category).css("stuff")
  end

  def make_books(category)
    #do I want the scraper to reset the book all variable?
    GoodreadsBestBooks2017::Book.reset
    scrape_books_index(category).each do |b|
      GoodreadsBestBooks2017::Book.new_from_index(b)
    end
  end


end
