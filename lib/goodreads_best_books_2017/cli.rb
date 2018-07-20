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
    c = GoodreadsBestBooks2017::Category.all[input-1]

    if input > 0 && input <= GoodreadsBestBooks2017::Category.all.length
      puts ""
      puts "Pulling 'Best' list for the #{c} category."

      self.print_books_list
      self.list_pick_book
    else
      self.bad_answer
      self.list_pick_category
    end
  end

  def list_pick_book #(might need a url argument?)
    puts ""
    puts "Which book would you like to see more details for?"
    puts "    - Please enter the book number from the list, or"
    puts "    -'back' to return to the Cateogry list."
    puts ""

    input = gets.strip

    if input.downcase == 'back'
      self.back_to_category_list
    elsif input.to_i >0 && input.to_i <= GoodreadsBestBooks2017::Book.all.length
      self.print_book_details
    else
      self.bad_answer
      self.list_pick_book
    end
  end

  def bad_answer
    puts ""
    puts "I don't understand that answer."
  end

  def print_categories
    puts ""
    puts "---------------Category List---------------"
    GoodreadsBestBooks2017::Category.all.each.with_index(1) do |c, i|
      puts "#{i}.   #{c}"
    end
    puts "-------------------------------------------"
  end

  def print_books_list #might need to take a category argument at some point
    puts ""
    puts "---------------Book List---------------"
    GoodreadsBestBooks2017::Book.all.each.with_index(1) do |b,i|
      puts "#{i}.   #{b}"
      end
    puts "---------------------------------------"
  end

  def print_book_details#eventually call on a book
    puts " "
    puts "---------------Book Details---------------"
    puts "Title:           book.title"
    puts "Author:          book.author"
    puts "Stars:           book.stars"
    puts "Pages:           book.pages"
    puts "Format:          book.format"
    puts "Published:       book.published"
    puts "Summary:          book.summary"
    puts "---------------Book Details---------------"
  end

  def back_to_category_list
    #will need to reset list of books
    #GoodreadsBestBooks2017::Book.reset
    self.list_pick_category
  end

end
