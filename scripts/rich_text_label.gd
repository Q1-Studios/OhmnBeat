extends RichTextLabel

var perfectString:String = "Perfect:						"
var greatString:String = "Great:						"
var missString:String = "Miss:							"
var pointString:String = "Total Score:			"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	print(ManagerGlobal.perfectAmount)
	perfectString = str(perfectString, ManagerGlobal.perfectAmount)
	print(ManagerGlobal.okAmount)
	greatString = str(greatString, ManagerGlobal.okAmount)
	print(ManagerGlobal.missAmount)
	missString = str(missString, ManagerGlobal.missAmount)
	print(ManagerGlobal.points)
	pointString = str(pointString, ManagerGlobal.points)
	setText()

func setText():
	text = perfectString + "\n" +"\n" + greatString + "\n" +"\n" + missString + "\n" +"\n" + pointString
	
