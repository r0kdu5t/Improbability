from random import choice

cave_numbers = range(0, 20)
caves = []
for i in cave_numbers:
	caves.append([])

for i in cave_numbers:
	for j in range(3):
		passage_to = choice(cave_numbers)
		caves[i].append(passage_to)
print caves
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
