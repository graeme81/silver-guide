require_relative("db/sql_runner")

class Film

  attr_accessor :id, :title, :price

  def initialize( options )
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price']
  end 

  def save()
    sql = "INSERT INTO films (title, price) VALUES ('#{ @title}', #{ @price }) RETURNING id"
    film = SqlRunner.run( sql ).first
    @id = film['id'].to_i
  end

  def self.delete_all() 
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM films"
    return Film.get_many( sql )
  end

  def self.get_many( sql )
    films = SqlRunner.run( sql )
    movies = films.map { |flick| Film.new( flick ) }
    return movies
  end

  def customers()
    sql = " SELECT customers.* FROM customers
            INNER JOIN tickets
            ON tickets.customer_id = customers.id
            WHERE film_id = #{@id};"

    return Customer.get_many( sql )     
  end

end
