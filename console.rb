require('pry')

require_relative('customer')
require_relative('film')
require_relative('ticket')

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({'name' => 'Tom', 'funds' => 100})
customer1.save()
customer2 = Customer.new({'name' => 'Dick', 'funds' => 75})
customer2.save()
customer3 = Customer.new({'name' => 'Harry', 'funds' => 20})
customer3.save()

film1 = Film.new({'title' => 'Joy', 'price' => 10})
film1.save()
film2 = Film.new({'title' => 'Star Wars', 'price' => 15})
film2.save()
film3 = Film.new({'title' => 'BFG', 'price' => 12})
film3.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()
ticket2 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film3.id})
ticket2.save()
ticket3 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id})
ticket3.save()
ticket4 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film2.id})
ticket4.save()
ticket5 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id})
ticket5.save()

binding.pry
nil