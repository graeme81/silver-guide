require_relative("db/sql_runner")

class Ticket

  attr_accessor = :id, :customer_id, :film_id

  def initialize( options )
    @id = options['id'].to_i
    @customer_id = options['customer_id']
    @film_id = options['film_id']
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id)
           VALUES ('#{ @customer_id }', '#{ @film_id }') RETURNING id"
    ticket = SqlRunner.run( sql ).first
    @id = ticket['id'].to_i
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


end
