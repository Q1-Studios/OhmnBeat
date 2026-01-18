extends Label
@export var manager:Node2D
var scoreText:String 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#TODO if time
	#We could make a kind of animated number thing, 
	#make a helper function that calculates the difference between current point
	#and what the nexr amount would be
	#then we would have a for loop replacing the text quickly making it look like
	#score increase is "animated" idk if it would look tacky
	#	-chris
	scoreText = str("Score: " , manager.points)
	text = scoreText
	pass
