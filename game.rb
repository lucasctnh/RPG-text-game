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
	#Warrior mechanic needs to be here because of the overriding
        if opponent.classe == "Warrior"
		r = rand(1..3)
		if r == 1
			opponent.health
			print "The Warrior #{@counter} managed to block the attack!\n"
		else
			#Assassins unique mechanic is 50% crit chance, as mencioned above
			a = rand(1..2)
			if a == 1
				opponent.health -= ((@power)*2)
				print "The Assassin #{@counter} hits a critical damage!\n"
			else
				opponent.health -= @power
			end
		end
	else
		a = rand(1..2)
		if a == 1
			opponent.health -= ((@power)*2)
			print "The Assassin #{@counter} hits a critical damage!\n"
		else
			opponent.health -= @power
		end
        end
    end
end

class Warrior < Player
    #Unique mechanic = 1/3 chance of blocking hits
end

class Mage < Player
	#Unique mechanic = able to use spells
	def hit(opponent)
		#Warrior mechanics also needs to be here
		if opponent.classe == "Warrior"
			r = rand(1..3)
			if r == 1
				opponent.health
				print "The Warrior #{@counter} managed to block the attack!\n"
			else
				#Mage mechanics that is 1/3 chance to cast each spell
				b = rand(1..3)
				if b == 1
					fireball(opponent)
				elsif b == 2
					iceshards(opponent)
				else
					opponent.health -= @power
				end
			end
		else
			b = rand(1..3)
			if b == 1
				fireball(opponent)
			elsif b == 2
				iceshards(opponent)
			else
				opponent.health -= @power
			end
		end
	end
	def fireball(opponent)
		opponent.health -= ((@power)*2)
		print "The Mage #{@counter} casted a Fireball!\n"
	end
	def iceshards(opponent)
		ics = rand(1..4)
		case ics
			when 1
			opponent.health -= ((@power)/2)
			print "The Mage #{@counter} summoned 1 ice shard to attack, it doesn't seem as much effective.\n"
			when 2
			opponent.health -= (((@power)/2)*2)
			print "The Mage #{@counter} summoned 2 ice shards to attack.\n"
			when 3
			opponent.health -= (((@power)/2)*3)
			print "The Mage #{@counter} summoned 3 ice shards to attack.\n"
			when 4
			opponent.health -= (((@power)/2)*4)
			print "The Mage #{@counter} managed to summon 4 ice shards to attack!\n"
		end
	end
end

#For each object show its to_s method
def show_info(*p)
    p.each { |x| puts x}
end

#Creating an ending fight option
def chooseopt
	opt = gets.chomp.capitalize
	if opt == "R"
		load 'game.rb'
	elsif opt == "E"
		exit
	else
		puts "Not a valid option."
		chooseopt
	end
end
#The fight is in turns
def fight1(p1, p2)
    turn = 0
    while p1.isAlive && p2.isAlive
        turn += 1
        puts "\nThis is turn #{turn}.\n\n"
		
		p1.hit(p2)
        p2.hit(p1)
		
        show_info(p1, p2)
    end
    if p1.isAlive 
        puts "Player 1: #{p1.name} Won!\n\nType R to restart or E to exit."
	chooseopt
    elsif p2.isAlive
        puts "Player 2: #{p2.name} Won!\n\nType R to restart or E to exit."
	chooseopt
    else
        puts "Tie!"
    end
end
def fight2(p1, p2)
    turn = 0
    while p1.isAlive && p2.isAlive
        turn += 1
        puts "\nThis is turn #{turn}.\n\n"
		
        p2.hit(p1)
	p1.hit(p2)
		
        show_info(p1, p2)
    end
    if p1.isAlive 
        puts "Player 1: #{p1.name} Won!\n\nType R to restart or E to exit."
	chooseopt
    elsif p2.isAlive
        puts "Player 2: #{p2.name} Won!\n\nType R to restart or E to exit."
	chooseopt
    else
        puts "Tie!"
    end
end

#From here I started using globals because I didn't find another way to do what I wanted
#Initialize player 1
def p1begin
	if $p1class == 1
		$p1 = Warrior.new(1, $p1name, "Warrior", rand(1..100), rand(1..20))
	elsif $p1class == 2
		$p1 = Mage.new(1, $p1name, "Mage", rand(1..100), rand(1..20))
	elsif $p1class == 3
		$p1 = Assassin.new(1, $p1name, "Assassin", rand(1..100), rand(1..20))
	else
		puts "#{$p1name}, you must choose one of the three classes using the corresponding number! Try again."
		$p1class = gets.chomp
		p1begin
	end
end

#Get the input of player 1 and set him into the specific class
puts "\nInput player 1 name and class, there are 3 classes avaiable: [1] Warrior, [2] Mage and [3] Assassin.\nPress ENTER between the inputs.\nPick the number according to the class."
$p1name = gets.chomp.capitalize
$p1class = gets.to_i
p1begin

#Initialize player 2
def p2begin
	if $p2class == 1
		$p2 = Warrior.new(2, $p2name, "Warrior", rand(1..100), rand(1..20))
	elsif $p2class == 2
		$p2 = Mage.new(2, $p2name, "Mage", rand(1..100), rand(1..20))
	elsif $p2class == 3
		$p2 = Assassin.new(2, $p2name, "Assassin", rand(1..100), rand(1..20))
	else
		puts "#{$p2name}, you must choose one of the three classes using the corresponding number! Try again."
		$p2class = gets.chomp
		p2begin
	end
end

#Get the input of player 2 and set him into the specific class
puts "\nAlso Input player 2 name and class."
$p2name = gets.chomp.capitalize
$p2class = gets.to_i
p2begin

#Show Player info
puts "\nPlayers Info"
show_info($p1, $p2)

#Creating a flipping coin to decide wich player goes first, 1 is heads and 2 is tails
def flipcoin1
	fp = rand(1..2)
	if fp == 1
		puts "Player 1 goes first."
		fight1($p1,$p2)
	else
		puts "Player 2 goes first."
		fight2($p1,$p2)
	end
end
def flipcoin2
	fp = rand(1..2)
	if fp == 1
		puts "Player 2 goes first."
		fight2($p1,$p2)
	else
		puts "Player 1 goes first."
		fight1($p1,$p2)
	end
end
def fp1inputmet
	puts "\nPlayer 1 please choose heads or tails."
	fp1input = gets.chomp.capitalize
	puts "\n"
	if fp1input == "Heads"
		flipcoin1
	elsif fp1input == "Tails"
		flipcoin2
	else
		puts "You must type heads or tails only."
		fp1inputmet
	end
end
fp1inputmet
