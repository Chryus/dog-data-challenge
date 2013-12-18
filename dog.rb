require 'mysql2'
require 'debugger'

 
class Dog
  attr_accessor :name, :color, :id 

  def initialize(name, color, id=nil)
    @name = name
    @color = color
    @id = id
  end

  @@db = Mysql2::Client.new(
    :host => "localhost", 
    :username => "root", 
    :database => "dogs")

  def db
    @@db
  end

  def self.db
    @@db
  end

  def insert
    db.query("insert into dogs(name, color)
      VALUES('#{self.name}', '#{self.color}')
      ")
      self.id = db.last_id
  end


  def self.find_by_id(id)
    temp_array = []
    temp =self.db.query("SELECT *
      FROM dogs
      WHERE id = #{id}")
    temp.each do |item|
      temp_array << Dog.new(item["name"], item["color"], item["id"])
    end
    temp_array
  end

  def self.find_by_name(name)
    self.db.query("SELECT *
      FROM dogs
      WHERE name = '#{name}' ").first
  end

  def self.find_by_color(color)
    self.db.query("SELECT *
      FROM dogs
      WHERE color = '#{color}' ").first
  end

  def mark_saved!
    self.id = self.db.last_id if self.db.last_id > 0
  end

  #save for later, 
  def update
    # if
    # mark_saved! 
      db.query("
        UPDATE dogs
        SET name = '#{name}', color ='#{color}'
        WHERE id = #{self.id}
        ")
     # else
     #  puts "sorry, nothing to update, the puppy doesn't exist!"
     # end
  end

  def save
    if self.id > 0
      self.update
    else
      self.insert
    end
    #if it has been saved, update
    #if it hasn't been saved, insert
  end

  def self.delete(id)
    #if marked_saved! == true
      self.db.query("
        DELETE FROM dogs
        WHERE id = #{id}")
    # else
    #   puts "sorry, no record there."
    # end
  end

end


# pup = Dog.find_by_name("fido") 
# puts pup
#puts pup.methods-Object.methods
#Dog.find_by_att(1)
 
#dog = Dog.find(10)
#debugger
#puts 'hi'
 
  # color, name, id
  # db


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