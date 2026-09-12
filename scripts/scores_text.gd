extends GridContainer


@export var perfectLabel: Label
@export var greatLabel: Label
@export var missLabel: Label
@export var noHitLabel: Label
@export var totalScoreLabel: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	perfectLabel.text = str(ManagerGlobal.perfectAmount)
	greatLabel.text = str(ManagerGlobal.okAmount)
	missLabel.text = str(ManagerGlobal.missAmount)
	noHitLabel.text = str(ManagerGlobal.noHitAmount)
	totalScoreLabel.text = str(ManagerGlobal.points, " Pts")
