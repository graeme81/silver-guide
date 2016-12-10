require_relative("db/sql_runner")

class Customer

  attr_accessor :id, :name, :funds

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ('#{ @name }', #{funds}) RETURNING id"
    customer = SqlRunner.run( sql ).first
    @id = customer['id'].to_i
  end

  def self.delete_all() 
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    return Customer.get_many( sql )
  end

  def self.get_many( sql )
    customers = SqlRunner.run( sql )
    people = customers.map { |person| Customer.new( person ) }
    return people
  end

  def films()
    sql = " SELECT films.* FROM films
            INNER JOIN tickets
            ON tickets.film_id = films.id
            WHERE customer_id = #{@id};"
    return Film.get_many( sql )     
  end

end
