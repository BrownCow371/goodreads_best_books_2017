class GoodreadsBestBooks2017::CLI

  def call
    GoodreadsBestBooks2017::Scraper.make_categories
    puts ""
    puts "Welcome to the Best books of 2017!"
    puts ""
    self.print_categories_list
    self.pick_a_category
  end

  def pick_a_category

    puts ""
    puts "Which category of books would you like to see the 'best' list for?"
    puts "    - Please enter the category number from the list."
    puts "    - or type 'Exit' to leave the application."

    input_category = gets.strip

    if input_category.to_i.between?(1, GoodreadsBestBooks2017::Category.all.length)

      @category = GoodreadsBestBooks2017::Category.find_by_id(input_category)
      puts ""
      puts "Pulling the 'Best' list for the '#{@category.name}' category."

      GoodreadsBestBooks2017::Scraper.make_books(@category.url) if GoodreadsBestBooks2017::Book.find_by_category(@category.url) == []

      self.print_books_list
      self.pick_a_book

    elsif input_category.downcase == "exit"
      self.goodbye

    else
      self.bad_answer
      self.pick_a_category
    end
  end

  def pick_a_book
    input_book = ""
    while input_book.downcase != "exit"
      puts ""
      puts "Which book would you like to see more details for?" if input_book == ""
      puts "    - Please enter the book number from the list to see details, or"
      puts "    - Enter 'List' to reprint the Book list for this category, or"
      puts "    - Enter 'Back' to return to the Cateogry list, or"
      puts "    - Enter 'Exit' to leave the application."
      puts ""

      input_book = gets.strip

      if input_book.downcase == 'back'
        self.back_to_category_list
      elsif input_book.to_i.between?(1, GoodreadsBestBooks2017::Book.find_by_category(@category.url).length)
        book = GoodreadsBestBooks2017::Book.find_by_category(@category.url)[input_book.to_i-1]
        self.print_book_details(book)
        self.pick_a_book
      elsif input_book.downcase == "list"
        self.print_books_list
        self.pick_a_book
      elsif input_book.downcase != "exit"
        self.bad_answer
        self.pick_a_book
      end
    end
    self.goodbye
  end

  def goodbye
    puts ""
    puts "Thank you for joining us!  Goodbye!"
    exit
  end

  def bad_answer
    puts ""
    puts "I don't understand that answer."
  end

  def print_categories_list
    puts ""
    puts "---------------Category List---------------"
    GoodreadsBestBooks2017::Category.all.each.with_index(1) do |c, i|
      puts "#{i}.   #{c.name}"
    end
    puts "-------------------------------------------"
  end

  def print_books_list
    puts ""
    puts "---------------Book List---------------"
    GoodreadsBestBooks2017::Book.find_by_category(@category.url).each.with_index(1) do |b, i|
      puts "#{i}.   #{b.title_author}"
      end
    puts "---------------------------------------"
  end

  def print_book_details(book)
    puts " "
    puts "---------------Book Details---------------"
    puts "Title:           #{book.title}"
    puts "Author:          #{book.author}"
    puts "Stars:           #{book.stars}"
    puts "Pages:           #{book.pages}"
    puts "Format:          #{book.book_format}"
    puts "Published:       #{book.published}"
    puts "URL:             https://www.goodreads.com#{book.url}"
    puts "-----------------Summary:-----------------"
    puts "#{book.desc} ..."
    puts "---------------Book Details---------------"
  end

  def back_to_category_list
    #GoodreadsBestBooks2017::Book.reset
    self.print_categories_list
    self.pick_a_category
  end
end
