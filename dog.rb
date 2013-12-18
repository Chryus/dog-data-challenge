require 'mysql2'
require 'debugger'

class Dog

  DB = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "dogs")

  attr_accessor :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  def self.db
    DB
  end

  def db
    DB
  end

  def self.find_dog_by_id(id)
    self.db.query("
      SELECT * 
      FROM dogs
      WHERE id = #{id}
      ")
      my_dogs = []
      temp = Dog.new(result["name"])
  end

  def self.find_dog_by_name(name)
    self.db.query("
      SELECT * 
      FROM dogs
      WHERE name = '#{name}'
      ")
  end

  def save_dog
    results = self.db.query("INSERT INTO dogs(name, color)
      VALUES('#{self.name}', '#{self.color}')"
      )
  end

  def change_dog(name, color, id)
    self.db.query("UPDATE dogs
      SET name = '#{name}', color = '#{color}'
      WHERE id = #{id}
      ")
  end

  def self.new_from_db row
    dog = Dog.new(row["name"], row["color"])
    dog.id = row["id"]
    dog  
  end 

  def mark_as_saved!
      self.id = self.db.last_id if self.db.last_id > 0
  end

end

dog = Dog.new("tucker", "blue")
dog.save_dog
puts Dog.find_dog(1).first
dog.change_dog("Marco", "red", 1)
#{"id"=>1, "name"=>"tucker", "color"=>"blue"}
#debugger
#puts 'hi'

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

