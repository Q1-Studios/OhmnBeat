extends GridContainer


@export var perfectLabel: Label
@export var greatLabel: Label
@export var missLabel: Label
@export var noHitLabel: Label
@export var totalScoreLabel: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	perfectLabel.text = str(ManagerGlobal.perfectAmount, "x")
	greatLabel.text = str(ManagerGlobal.okAmount, "x")
	missLabel.text = str(ManagerGlobal.missAmount, "x")
	noHitLabel.text = str(ManagerGlobal.noHitAmount, "x")
	totalScoreLabel.text = str(ManagerGlobal.points, " Pts")
