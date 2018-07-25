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
      puts "Pulling the 'Best' list for the '#{category.name}' category."

      GoodreadsBestBooks2017::Scraper.make_books(category.url) if something

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
    puts ""
    puts "Which book would you like to see more details for?"
    puts "    - Please enter the book number from the list, or"
    puts "    - 'Back' to return to the Cateogry list, or"
    puts "    - 'Exit' to leave the application."
    puts ""
input_book = ""
while input_book != "exit" do
    input_book = gets.strip

    if input_book.downcase == 'back'
      self.back_to_category_list
    elsif input_book.downcase == 'exit'
      self.goodbye
    elsif input_book.to_i.between?(1, GoodreadsBestBooks2017::Book.find_by_category(@category.name).length)

    #  book =  GoodreadsBestBooks2017::Book.find_by_id(input_book)
      book = GoodreadsBestBooks2017::Book.find_by_category(category)[i.to_i -1]

      self.print_book_details(book)

      puts ""
      puts "Would you like to see details for another book in the current category?"
      puts "    -Enter Y if you would like to pick another book from the list, or"
      puts "    -Enter 'Back' if you would like to pick a different Cateogry, or"
      puts "    -Enter 'Exit' if you would like to leave the application."

      input_another_book = gets.strip.downcase
        if input_another_book == "y"
          self.print_books_list
          self.pick_a_book
        elsif input_another_book =="exit"
          self.goodbye
        elsif input_another_book == "back"
          self.back_to_category_list
        else
          self.bad_answer
          self.pick_a_book
        end
    else
      self.bad_answer
      self.pick_a_book
    end
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
    GoodreadsBestBooks2017::Book.all.each.with_index(1) do |b, i|
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
    GoodreadsBestBooks2017::Book.reset
    self.print_categories_list
    self.pick_a_category
  end
end
