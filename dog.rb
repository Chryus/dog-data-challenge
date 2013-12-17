require 'mysql2'

class Dog
  
  @@db = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "dogs")

end

dog = Dog.find(10)
debugger
puts 'hi'

  # color, name, id
  # db
  # find_by_att
  # find
  # insert
  # update
  # delete/destroy

  # refactorings?
  # new_from_db?
  # saved?
  # save! (a smart method that knows the right thing to do)
  # unsaved?
  # mark_saved!
  # ==
  # inspect
  # reload
  # attributes

