require 'pry'

class Student
  @@all = []
  attr_accessor :name, :grade
  attr_reader :id
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
    @@all << self
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTERGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      )
      SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE IF EXISTS students
      SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?,?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade)

    # sql_2 = <<-SQL
    #   SELECT id FROM students
    #   WHERE name = (?)
    # SQL
    # binding.pry
    @id = DB[:conn].execute("SELECT last_insert_rowid() from STUDENTS")[0][0]

    sql_3 = <<-SQL
      UPDATE students
      SET id = (?)
      WHERE name = (?)
    SQL
    DB[:conn].execute(sql_3, @id, self.name)
    # binding.pry
  end

  def self.create(name:, grade:)
    stude = Student.new(name, grade)
    stude.save
    stude
  end


end
