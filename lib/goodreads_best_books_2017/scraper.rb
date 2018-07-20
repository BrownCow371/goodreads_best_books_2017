class GoodreadsBestBooks2017::Scraper

  def get_page_categories
    Nokogiri::HTML(open("https://www.goodreads.com/choiceawards/best-books-2017"))
  end

  def scrape_categories_index
    self.get_page_categories.css("div.categoryContainer div.category.clearFix")
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
    #Nokogiri::HTML(open("https://www.goodreads.com/choiceawards/best-fiction-books-2017"))
    #and cateogry URLs are stored as /choiceawards/best-fiction-books-2017
    Nokogiri::HTML(open("https://www.goodreads.com#{category_url}"))
  end

  def scrape_books_index(category_url)
    index_scrape = self.get_page_books(category_url).css("a.pollAnswer__bookLink")
    book_index_array = []
    index_scrape.each do |book|
      book_index_array<<book.attribute("href").text
    end
    book_index_array
  end

  def scrape_book_profile(book_url)
    #book urls look like "/book/show/34273236-little-fires-everywhere?from_choice=true"
    #and the page I need to scrape looks like https://www.goodreads.com/book/show/34273236-little-fires-everywhere?from_choice=true
    #Nokogiri::HTML(open("https://www.goodreads.com/book/show/34273236-little-fires-everywhere?from_choice=true")).css("div#metacol")

    #summary: profile.css("div#description span p").text,
    profile_scrape = Nokogiri::HTML(open("https://www.goodreads.com#{book_url}")).css("div#metacol")
    book_profile = {}

    profile_scrape.each do |profile|
      book_profile = {
        title: profile.css("h1#bookTitle").text.strip,
        author: profile.css("a.authorName").text,
        stars: profile.css("span.value.rating span").text,
        book_format: profile.css("div#details div span[itemprop='bookFormat']").text,
        pages: profile.css("div#details div span[itemprop='numberOfPages']").text,
        published: profile.css("div#details div.row")[1].text.strip.gsub("\n","")
      }
    end
    book_profile
  end


  def make_books(category_url)
    GoodreadsBestBooks2017::Book.reset #do I want the scraper to reset the book all variable?

    book_array = scrape_books_index(category_url)

    GoodreadsBestBooks2017::Book.new_from_array(book_array)

    GoodreadsBestBooks2017::Book.all.each do |book|
      attributes = scrape_book_profile(book.url)
      book.add_attributes(attributes)
    end
  end


end
