class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id=id
  end


  def self.create_table
    sql = "CREATE TABLE IF NOT EXISTS
    students (
      id INTEGER PRIMARY KEY
      name TEXT,
      grade TEXT
      )"
      DB[:conn].execute(sql)
  end


  def self.drop_table
    sql = "DROP TABLE name;"
  end

  def save
    sql = "INSERT INTO students (name, grade)
    VALUES (?, ?)"
    DB[:conn].execute(sql, self.name, self.grade)
  end

  def self.create(name, grade)
    student = Student.new(name, grade)
    student.save
    student
  end
end

# Remember, you can access your database connection anywhere in this class
#  with DB[:conn]
