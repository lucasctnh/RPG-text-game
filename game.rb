#Defining the superclass and its general methods
class Player
    attr_accessor :counter, :name, :classe, :health, :power
    def initialize(co, n, c, h, pow)
	@counter = co
        @name = n
        @classe = c
        @health = h
        @power = pow
    end
    def to_s
        "Player #{counter}: #{name}, #{classe}, Health: #{health}, Power: #{power}"
    end
    def isAlive
        @health > 0
    end
    def hit(opponent)
        opponent.health -= @power
    end
end

#Creating specific classes
class Assassin < Player
    #Unique mechanic = crit chance 50%
    def hit(opponent)
        a = rand(1..2)
        if a == 1
            opponent.health -= ((@power)*2)
        else
            opponent.health -= @power
        end
    end
end

class Warrior < Player
    #Unique mechanic = 50% chance of blocking hits
end

class Mage < Player
    #Unique mechanic = able to use spells
    def hit(opponent)
        #50% chance each spell
        b = rand(1..2)
        if b == 1
            fireball
        else
            thunderstrike
        end
    end
    def fireball(opponent)
        opponent.health -= ((@power)*2)
    end
    def thunderstrike(opponent)
        opponent.health -= @power
        stun
    end
    #opponent loses 1 turn
    def stun(opponent)
    end
        
end

#For each object show its to_s method
def show_info(*p)
    p.each { |x| puts x}
end

#Fighting is in turns
def fight(p1, p2)
    turn = 0
    while p1.isAlive && p2.isAlive
        p1.hit(p2)
        p2.hit(p1)
        
        turn += 1
        puts "This is turn #{turn}."
        show_info(p1, p2)
    end
    if p1.isAlive 
        puts "Player 1: #{p1.name} Won!" 
    elsif p2.isAlive
        puts "Player 2: #{p2.name} Won!" 
    else
        puts "Tie!"
    end
end

#Get the input of the players and set them into the specific class
puts "\nInput player 1 name and class, there are 3 classes avaiable: Warrior, Mage and Assassin."
p1name = gets.chomp.capitalize
p1class = gets
puts "\nAlso Input player 2 name and class."
p2name = gets.chomp.capitalize
p2class = gets
#Initialize the players
if p1class == "Warrior"
	p1 = Warrior.new(1, p1name, "Warrior", rand(1..100), rand(1..20))
elsif p1class == "Mage"
    p1 = Mage.new(1, p1name, "Mage", rand(1..100), rand(1..20))
else
    p1 = Assassin.new(1, p1name, "Assassin", rand(1..100), rand(1..20))
end

if p2class == "Warrior"
    p2 = Warrior.new(2, p2name, "Warrior", rand(1..100), rand(1..20))
elsif p2class == "Mage"
    p2 = Mage.new(2, p2name, "Mage", rand(1..100), rand(1..20))
else
    p2 = Assassin.new(2, p2name, "Assassin", rand(1..100), rand(1..20))
end 

#Show Player info
puts "Players Info"
show_info(p1, p2)

puts "FIGHT!"
fight(p1, p2)
