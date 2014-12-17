class Employee
  attr_accessor :salary

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end
end

class Manager < Employee
  attr_accessor :subordinates

  def initialize(name, title, salary, boss)
    super(name,title,salary,boss)
  end

  def bonus(multiplier)
    total_salary = 0
    employee_queue = subordinates
    until employee_queue.empty?
      current_employee = employee_queue.shift
      total_salary += current_employee.salary
      if current_employee.is_a? Manager
        current_employee.subordinates.each { |employee| employee_queue << employee }
      end
    end
    total_salary * multiplier
  end


end

# set up people
ned = Manager.new("ned", "founder", 1_000_000, nil)
darren = Manager.new("darren", "ta manager", 78_000, ned)
shawna = Employee.new("shawna", "ta", 12_000, darren)
david = Employee.new("shawna", "ta", 10_000, darren)
ned.subordinates = [darren]
darren.subordinates = [shawna, david]


p ned.bonus(5) # => 500_000
p darren.bonus(4) # => 88_000
p david.bonus(3) # => 30_000
