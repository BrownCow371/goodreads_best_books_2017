class GoodreadsBestBooks2017::CLI

  def call
    puts ""
    puts "Welcome to the Best books of 2017!"
    self.list_pick_category
  end

  def list_pick_category
    puts ""
    puts "Which category of books would you like to see the 'best' list for?"
    puts "    - Please enter the category number from the list."
    self.print_categories
    input = gets.strip.to_i
  end

  def pick_book #(might need a url argument?)
  end

  def print_categories
  end

  def print_books_list
  end

  def print_book_details
  end

  def back_to_category_list
    #will need to reset list of books
    #GoodreadsBestBooks2017::Book.reset
    self.list_pick_category
  end



end
