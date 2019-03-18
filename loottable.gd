#to use just create a new instance of this class and 
#then add however many items you want and their weights. 
#then you can use one of the roll functions to retrieve an item
#example:
#var loottable = load("path-to-script")
#var table = loottable.new()
#table.add_item("shortsword",100)
#table.add_item("dragon egg",10)
#table.add_item(null,1000)
#table.add_item("poisoned dagger",1)
#table.add_item("breadsticks",3)
#
#var item = table.roll()
#
#print(item)
#

extends Node

var data = []

#adds item to database
func add_item(item,weight):
	data.append([item,weight])


#removes item from database
func remove_item(value):
	data.erase(value)


func create_from_array(array):
	data = array


#returns an item from the database from a roll based on the item weights
func roll():
	
	var roll_max = 0
	
	for i in data.size():
		roll_max += data[i][1]
	
	var roll = rand_range(0,roll_max)
	
	var result
	var mini = 0
	var maxi = 0
	var last_maxi = 0
	
	for i in data.size():
		mini = last_maxi
		
		if(i!=data.size()):
			maxi = mini + data[i][1]
		
		if(roll>mini && roll<maxi):
			result = data[i][0]
		
		last_maxi += data[i][1]
	
	return(result)


#returns an array containing n amount of items
func roll_n(n):
	var result = []
	for i in n:
		result.append(roll())
	return(result)


#returns an array containing n amount of unique items. If n is the same size or larger than the table size, will return entire loot table
func roll_n_unique(n):
	var table = get_script().new()
	table.create_from_array(data)
	var result = []

	if n >= data.size():
		for i in data.size():
			result.append(data[i][0])
	else:
		for i in n:
			result.append(table.roll())
			table.remove_item(result)

	return(result)