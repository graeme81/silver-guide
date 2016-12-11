require_relative("db/sql_runner")

class Ticket

  attr_accessor  :id, :customer_id, :film_id

  def initialize( options )
    @id = options['id'].to_i
    @customer_id = options['customer_id']
    @film_id = options['film_id']
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id)
           VALUES ('#{ @customer_id }', '#{ @film_id }') 
           RETURNING id"
    ticket = SqlRunner.run( sql ).first
    @id = ticket['id'].to_i

   #charge_customer()

  end

  def charge_customer()
    sql = "SELECT f.price, c.name, c.funds FROM films f
           INNER JOIN tickets t
           ON f.id = t.film_id
           INNER JOIN  customers c
           ON c.id = t.customer_id
           WHERE f.id = #{@film_id}
           AND c.id = #{@customer_id}"
    info = SqlRunner.run( sql ).first
    charge = info['price'].to_i
    name = info['name']
    money = info['funds'].to_i
    funds = money - charge

    binding.pry

    Customer.update(name, funds, customer_id)

  end

  def self.delete_all() 
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    return Ticket.get_many( sql )
  end

  def self.get_many( sql )
    tickets = SqlRunner.run( sql )
    ticket_objects = tickets.map { |stubs| Ticket.new( stubs ) }
    return ticket_objects
  end

  def update()
    sql = "UPDATE tickets 
           SET (customer_id ,film_id) = (#{@customer_id}, #{film_id})
           WHERE id = #{@id};"
    SqlRunner.run(sql)
  end


end
