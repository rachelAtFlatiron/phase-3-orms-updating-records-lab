require_relative "../config/environment.rb"
require 'pry'

class Student
  attr_reader :id
  attr_accessor :name, :grade

  #instantiate
  def initialize(id=nil, name, grade)
    @id = id
    @name = name 
    @grade = grade 
  end 

  #create table
  def self.create_table 
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      )
    SQL
    DB[:conn].execute(sql)
  end

  #delete table
  def self.drop_table
    sql = <<-SQL
      DROP TABLE IF EXISTS students
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO students(name, grade) VALUES(?, ?)
    SQL
    result = DB[:conn].execute(sql, self.name, self.grade)
    sql = <<-SQL
      SELECT last_insert_rowid() FROM students
    SQL
    self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    self
  end 

  # def self.create 
  # end 

  # #params: (array) 3 elements, id, name, grade 
  # #new student object
  # def self.new_from_db(array)
  # end

  # #params: (string) name 
  # #finds record by name to instantiate STudent object with database row
  # def self.find_by_name(name)
  # end 

  # #updates database row
  # def update 
  # end 
end

