class DomesticGoods::CLI

  def call
    prompt
  end

def prompt
  puts "\n"
  puts "Welcome to Domestic Goods, a directory of American-made companies. Would you like to search brands:"
  puts "\n"+"1. Randomly\n2. By Category"
  input = gets.strip.downcase
  case input
  when "1", "1.", "randomly", "random"
    assorted_goods
  when "2", "2.", "by category"
    category_selector
  when "exit"
    hard_out
  else
    puts "Sorry, I didn't catch that. Please enter either 1, 2, or exit."
    prompt
  end
end

def assorted_goods
  DomesticGoods::AmericanList.assorted_scraper
  @assorted_companies = DomesticGoods::AmericanList.lists
  input = nil
  answer = nil
  puts "How many companies would you like to see? 5 or 10? Type exit to leave."
    input = gets.strip.downcase
      case input
      when "5"
        five_assorted_companies
      when "10"
        ten_assorted_companies
      when "exit"
        hard_out
      else
        puts "Sorry, I didn't catch that."
        assorted_goods
      end
  end


def five_assorted_companies
  @assorted_companies.shuffle![0..4].map.with_index(1) do |company,index|
  puts "\n" + "#{index}. Company: #{company.name}\n   Category: #{company.category}"
  end
  assorted_companies_prompt(5,4)
end

def ten_assorted_companies
  @assorted_companies.shuffle![0..9].map.with_index(1) do |company,index|
  puts "\n" + "#{index}. Company: #{company.name}\n   Category: #{company.category}"
  end
  assorted_companies_prompt(10,9)
end



def assorted_companies_prompt(companies,index_count)
  puts "\n" + "-Learn more about a company above by entering its number(1-#{companies})"
  puts "-See more companies by entering 'more'"
  puts "-Go back to main menu by entering 'menu'"
  puts "-Exit by entering 'exit'"
  answer = gets.strip.downcase

  counter = companies

  while counter > 0
    if answer == counter.to_s
      puts "Company: #{@assorted_companies[counter - 1].name}\nLocation: #{@assorted_companies[counter - 1].location}\nWebsite: #{@assorted_companies[counter - 1].url} "
      see_more?(index_count)
    end
    counter-=1
  end

  if answer == "more"
    assorted_goods
  elsif answer == "menu"
    prompt
  elsif answer == "exit"
    hard_out
  else
    puts "Sorry, I didn't get that. You can type 'more', 'menu', 'exit', or the number of the company you're interested in."
    assorted_companies_prompt(companies, index_count)
  end

end

def see_more?(index)
    puts "\n" + "Would you like to 1. Go back 2. See more companies 3. Main menu 4. Exit"
    input = gets.strip.downcase
    case input
    when "1" || "back"
      @assorted_companies[0..index].map.with_index(1) do |company,index|
      puts "\n" + "#{index}. Company: #{company.name}\nCategory: #{company.category}"
      end
      if index == 4
        assorted_companies_prompt(5,4)
      elsif index == 9
        assorted_companies_prompt(10,9)
      end
    when "2", "see more"
      assorted_goods
    when "3", "menu"
      prompt
    when "4", "exit"
      hard_out
    else
      puts "Sorry, I didn't get that."
      see_more?(index)
    end
  end

  def category_selector
    puts "Which kind of companies would you like to see?"
    puts "\n" + "1. Women's Apparel\n2. Men's Apparel\n3. Home Goods\n4. Gifts"
    input = gets.strip.downcase
    case input
    when "1", "1.", "women", "women's apparel", "womens apparel"
      DomesticGoods::AmericanList.category_scraper("women")
      print_the_list
    when "2", "2.", "men", "men's apparel", "mens apparel"
      DomesticGoods::AmericanList.category_scraper("men")
      print_the_list
    when "3", "3.", "home", "home goods"
      DomesticGoods::AmericanList.category_scraper("home")
      print_the_list
    when "4", "4.", "gifts"
      DomesticGoods::AmericanList.category_scraper("gifts")
      print_the_list
    when "exit"
      hard_out
    else
      puts "Sorry, I didn't catch that."
      category_selector
    end
  end

def print_the_list
  print_info(DomesticGoods::AmericanList.lists)
end

def print_info(product_list)
  list = product_list

  input = nil
  answer = nil
  puts "How many different companies would you like to see? 5 or 10? Type exit to leave."
    input = gets.strip.downcase
      case input
      when "5"
        list.shuffle[0..4].each do |company|
          puts "\n" + "Company: #{company.name}\nDescription: #{company.description}\nWebsite: #{company.url}"
        end
        after_print_prompt(product_list)
      when "10"
        list.shuffle[0..9].each do |company|
          puts "\n" + "Company: #{company.name}\nDescription: #{company.description}\nWebsite: #{company.url}"
        end
        after_print_prompt(product_list)
      when "exit"
        hard_out
      else
          puts "Sorry, I didn't get that."
          print_info(product_list)
      end
end

def after_print_prompt(product_list)
  puts "\n" + "What would you like to do now? 1. See more 2. Go to main menu or 3. exit?"
  answer = gets.strip.downcase
    if answer == "1" || answer == "more" || answer == "see more"
      print_info(product_list)
    elsif answer == "2" || answer == "menu" || answer == "2."
      prompt
    elsif answer == "3" || answer == "exit"
      hard_out
    else
      puts "\n" + "Sorry, I didn't get that."
      after_print_prompt(product_list)
    end
end

def hard_out
  puts "Thanks for stopping by. See you next time."
  exit
end


end
