class GoodreadsBestBooks2017::Scraper

  def get_page_categories
    Nokogiri::HTML(open("https://www.goodreads.com/choiceawards/best-books-2017"))
  end

  def scrape_categories_index
    self.get_page_categories.css("div.categoryContainer div.category.clearFix")
    binding.pry
  end

  def make_categories
    self.scrape_categories_index.each do |c|
      name = c.css("h4").text
      url = c.css("a").attribute("href").text
      GoodreadsBestBooks2017::Category.new(name, url)
    end
  end

  def get_page_books(category_url)
    #want URL to be something like https://www.goodreads.com/choiceawards/best-fiction-books-2017
    Nokogiri::HTML(open("https://www.goodreads.com/choiceawards/best-fiction-books-2017"))
    #and cateogry URLs are stored as /choiceawards/best-fiction-books-2017
    Nokogiri::HTLM(open("https://www.goodreads.com#{category_url}"))
  end

  def scrape_books_index(category)
    index_scrape = self.get_page_books(category).css("a.pollAnswer__bookLink")
    book_index_array = []
    index_scrape.each do |book|
      book_index_array<<book.attribute("href").text
    end
    book_index_array
  end

  def scrape_book_profile(book_url)
    #book urls look like "/book/show/34273236-little-fires-everywhere?from_choice=true"
    #and the page I need to scrape looks like https://www.goodreads.com/book/show/34273236-little-fires-everywhere?from_choice=true
    profie_scrape = Nokogiri::HTLM(open("https://www.goodreads.com#{book_url}")).css("div#metacol")

    Nokogiri::HTML(open("https://www.goodreads.com/book/show/34273236-little-fires-everywhere?from_choice=true")).css("div#metacol")

    book_profile = {}

    profile_scrape.each do |profile|
      book_profile = {
        title: profile.css("h1#bookTitle").text.strip
        author:
        summary:
        stars:
        format:
        pages:
        published:
      }
  end


  def make_books(category)
    #do I want the scraper to reset the book all variable?
    GoodreadsBestBooks2017::Book.reset
    scrape_books_index(category).each do |b|
      GoodreadsBestBooks2017::Book.new_from_index(b)
    end
  end


end
