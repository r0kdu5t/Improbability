import random

def create_tunnel(cave_from, cave_to):
	""" Create a tunnel between cave_from and cave_to.  """
	caves[cave_from].append(cave_to)
	caves[cave_to].append(cave_from)

def visit_cave(cave_number):
	""" Mark a cave as visited. """
	visited_caves.append(cave_number)
	unvisited_caves.remove(cave_number)

def choose_cave(cave_list):
	""" Pick a cave from a list, provided that the cave has \
	less than three (3) tunnels. """
	cave_number = choice(cave_list)
	while len(caves[cave_number]) >= 3:
		cave_number = choice(cave_list)
	return cave_number

def print_caves():
	""" Print out the current cave structure!
	"""
	for number in cave_numbers:
		print(number, ":", caves[number])
	print("----------")

cave_numbers = range(0, 20)
caves = []
for i in cave_numbers:
	caves.append([])

unvisited_caves = range(0, 20)
visited_caves = [0]
unvisited_caves.remove(0)

while unvisited_caves != []:
	i = choice(visited_caves)
	if len(caves[i] >= 3):
		continue

	next_cave = choice(unvisited_caves)
	caves[i].append(next_cave)
	caves[next_cave].append(i)

	visited_caves.append(next_cave)
	unvisited_caves.remove(next_cave)



for i in cave_numbers:
	while len(caves[i]) < 3:
		passage_to = choice(cave_numbers)
		caves[i].append(passage_to)

	for number in cave_numbers:
		print(number, ":", caves[number])
	print("----------")		

wumpus_location = choice(cave_numbers)
player_location = choice(cave_numbers)
while player_location == wumpus_location:
	player_location = choice(cave_numbers)

print("Welcome to Hunt the Wumpus!")
print("You can see", len(cave_numbers), "caves")
print("To play, just type the number")
print("of the cave you wish to enter next.")

while True:
	print("You are in cave", player_location)
	print("From here, you can see caves: ", caves[player_location])
	if wumpus_location in caves[player_location]:
		print("I smell a wumpus!")

	print("Which cave next?")
	player_input = raw_input("> ")
	if (not player_input.isdigit() or int(player_input) not in caves[player_location]):
		print(player_input, " ?")
		print("That's not a direction that I can see!")

	else:
		player_location = int(player_input)
		if player_location == wumpus_location:
			print("Aargh! You got eaten by a wumpus!")
			break
